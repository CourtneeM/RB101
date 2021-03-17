require 'pry'

TARGET_NUM = 21
DEALER_HIT_UNTIL = 17
ROUNDS_TO_WIN = 3

def clear_screen
  system('clear') || system('cls')
end

def joinand(arr)
  case arr.size
  when 2
    arr.join(' and ')
  when (2..nil)
    arr.join(', ').split.insert(-2, 'and').join(' ')
  end
end

def prompt(message)
  puts "=> #{message}"
end

def display_welcome
  clear_screen
  welcome = "Welcome to Twenty-One!"
  rules = "Closest to #{TARGET_NUM} without going over wins."
  border = "========================================="
  spacing1 = "\s" * ((border.size - welcome.size) / 2)
  spacing2 = "\s" * ((border.size - rules.size) / 2)
  puts "#{border}\n#{spacing1 + welcome}\n#{spacing2 + rules}\n#{border}"
end

def display_goodbye
  puts "======================================="
  puts "Thanks for playing Twenty-One! Goodbye."
  puts "======================================="
end

def display_hands(player_hand, dealer_hand, totals, results = false)
  player_values = values(player_hand)
  dealer_values = values(dealer_hand)

  case results
  when true
    puts "Dealer has: #{joinand(dealer_values)} " \
         "for a total of #{totals['dealer']}"
  when false
    puts "Dealer has: #{dealer_values[0]} and unknown card"
  end
  puts "You have: #{joinand(player_values)} for a total of #{totals['player']}"
end

def display_scores(scores)
  puts "[Player: #{scores['player']} | Dealer: #{scores['dealer']}]"
  puts "-----------------------"
end

def initialize_deck
  suits = ['H', 'D', 'C', 'S']
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  suits.product(values).shuffle
end

def deal_cards(deck)
  player_hand = []
  dealer_hand = []

  2.times { [player_hand, dealer_hand].each { |hand| hand << deck.pop } }

  [player_hand, dealer_hand]
end

def player_turn(player_hand, dealer_hand, deck, totals, scores)
  loop do
    display_scores(scores)
    display_hands(player_hand, dealer_hand, totals)

    case hit_or_stay
    when :hit
      hit(player_hand, deck)
      update_total(player_hand, totals, 'player')
      break if busted?(totals['player'])
      clear_screen
    when :stay
      break
    end
  end

  puts("You chose to stay!") unless busted?(totals['player'])
end

def dealer_turn(dealer_hand, deck, totals)
  loop do
    break if totals['dealer'] >= DEALER_HIT_UNTIL || busted?(totals['dealer'])
    hit(dealer_hand, deck)
    update_total(dealer_hand, totals, 'dealer')
  end
end

def hit_or_stay
  loop do
    prompt("Hit or stay?")
    answer = gets.chomp.downcase

    if answer == 'hit' || answer == 'h'
      return :hit
    elsif answer == 'stay' || answer == 's'
      return :stay
    end
    prompt("That's not a valid choice.")
  end
end

def hit(hand, deck)
  hand << deck.pop
end

def busted?(total)
  total > 21
end

def update_total(hand, totals, current_player)
  totals[current_player] = total(values(hand))
end

def values(hand)
  hand.map { |card| card[1] }
end

def total(hand_values)
  total = hand_values.map do |value|
    if ['J', 'Q', 'K'].include?(value)
      10
    elsif value == 'A'
      11
    else
      value.to_i
    end
  end.sum

  hand_values.count('A').times { total -= 10 if total > 21 }
  total
end

def detect_round_winner(totals)
  player_total, dealer_total = totals.values_at('player', 'dealer')

  if busted?(player_total)
    :player_busted
  elsif busted?(dealer_total)
    :dealer_busted
  elsif player_total > dealer_total
    :player
  elsif dealer_total >= player_total
    :dealer
  end
end

def display_round_winner(winner)
  message = case winner
            when :player_busted then "You busted! Dealer wins!"
            when :dealer_busted then "Dealer busted! You win!"
            when :player then "You won!"
            when :dealer then "Dealer won!"
            end
  border = "----------------------------"
  spacing = "\s" * ((border.size - message.size) / 2)
  puts "#{border}\n#{spacing + message}\n#{border}"
end

def match_winner?(scores)
  scores.any? { |_, v| v == ROUNDS_TO_WIN }
end

def increment_score(scores, winner)
  winner = 'player' if [:dealer_busted, :player].include?(winner)
  winner = 'dealer' if [:player_busted, :dealer].include?(winner)
  scores[winner] += 1
end

def next_round_prompt
  prompt("Hit enter to start next round.")
  gets.chomp
  clear_screen
end

def play_again?
  loop do
    prompt("Do you want to play again? (yes or no)")
    answer = gets.chomp.downcase
    if answer == 'yes' || answer == 'y'
      return true
    elsif answer == 'no' || answer == 'n'
      return false
    end
    prompt("That's not a valid choice.")
  end
end

loop do
  display_welcome
  scores = { 'player' => 0, 'dealer' => 0 }

  loop do
    deck = initialize_deck
    player_hand, dealer_hand = deal_cards(deck)
    totals = { 'player' => total(values(player_hand)),
               'dealer' => total(values(dealer_hand)) }

    player_turn(player_hand, dealer_hand, deck, totals, scores)
    clear_screen

    unless busted?(totals['player'])
      dealer_turn(dealer_hand, deck, totals)
    end

    increment_score(scores, detect_round_winner(totals))
    display_scores(scores)
    display_hands(player_hand, dealer_hand, totals, true)
    display_round_winner(detect_round_winner(totals))

    break if match_winner?(scores)
    next_round_prompt
  end
  # display_match_winner(scores)
  break unless play_again?
end

display_goodbye
