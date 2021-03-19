TARGET_NUM = 21
DEALER_HIT_UNTIL = 17
ROUNDS_TO_WIN = 5
BORDER_SIZE = 50
DOUBLE_BORDER = "=" * BORDER_SIZE
BORDER = "-" * BORDER_SIZE

def clear_screen
  system('clear') || system('cls')
end

def joinand(arr)
  case arr.size
  when 2
    arr.join(' and ')
  when (2..nil)
    arr.join(', ').split.insert(-4, 'and').join(' ')
  end
end

def prompt(message)
  puts "=> #{message}"
end

def display_welcome
  clear_screen
  welcome = "Welcome to Whatever-One!"
  rules1 = "Closest to #{TARGET_NUM} without going over wins the round."
  rules2 = "First to 5 points wins the match."
  spacing1, spacing2, spacing3 = [welcome, rules1, rules2].map do |message|
    "\s" * ((DOUBLE_BORDER.size - message.size) / 2)
  end

  puts "#{DOUBLE_BORDER}\n#{spacing1 + welcome}"
  puts "#{spacing2 + rules1}\n#{spacing3 + rules2}\n#{DOUBLE_BORDER}"
end

def display_goodbye
  message = "Thanks for playing Whatever-One! Goodbye."
  spacing = "\s" * ((DOUBLE_BORDER.size - message.size) / 2)

  puts "#{DOUBLE_BORDER}\n#{spacing + message}\n#{DOUBLE_BORDER}"
end

def display_hands(player_hand, dealer_hand, totals, results = false)
  player_hand_details = player_hand.map do |card|
    "#{card[:value]} of #{card[:suit]}"
  end
  dealer_hand_details = dealer_hand.map do |card|
    "#{card[:value]} of #{card[:suit]}"
  end

  case results
  when true
    puts "Dealer has: #{joinand(dealer_hand_details)} " \
         "for a total of #{totals['dealer']}"
  when false
    puts "Dealer has: #{dealer_hand_details[0]} and unknown card"
  end
  puts "You have: #{joinand(player_hand_details)} for " \
       "a total of #{totals['player']}"
end

def display_scores(scores)
  message = "Player: #{scores['player']} | Dealer: #{scores['dealer']}"
  spacing = "\s" * ((BORDER.size - message.size) / 2)
  puts "#{BORDER}\n#{spacing + message}\n#{BORDER}"
end

def display_rounds_played(round)
  puts "Total Rounds Played: #{round}"
end

def initialize_deck
  suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  values = ['2', '3', '4', '5', '6', '7', '8', '9',
            '10', 'Jack', 'Queen', 'King', 'Ace']
  suits.product(values).shuffle
end

def deal_cards!(deck)
  player_hand = []
  dealer_hand = []

  2.times do
    [player_hand, dealer_hand].each do |hand|
      card = deck.pop
      hand << { suit: card[0], value: card[1] }
    end
  end

  [player_hand, dealer_hand]
end

def player_turn!(player_hand, dealer_hand, deck, totals, scores)
  loop do
    display_scores(scores)
    display_hands(player_hand, dealer_hand, totals)

    case hit_or_stay
    when :hit
      hit!(player_hand, deck)
      update_total!(player_hand, totals, 'player')
      break if busted?(totals['player'])
      clear_screen
    when :stay
      break
    end
  end

  puts("You chose to stay!") unless busted?(totals['player'])
end

def dealer_turn!(dealer_hand, deck, totals)
  loop do
    break if totals['dealer'] >= DEALER_HIT_UNTIL || busted?(totals['dealer'])
    hit!(dealer_hand, deck)
    update_total!(dealer_hand, totals, 'dealer')
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

def hit!(hand, deck)
  card = deck.pop
  hand << { suit: card[0], value: card[1] }
end

def busted?(total)
  total > TARGET_NUM
end

def update_total!(hand, totals, current_player)
  totals[current_player] = total(hand)
end

def total(hand)
  values = hand.map { |card| card[:value] }
  total = values.map do |value|
    if ['Jack', 'Queen', 'King'].include?(value)
      10
    elsif value == 'Ace'
      11
    else
      value.to_i
    end
  end.sum

  values.count('Ace').times { total -= 10 if total > TARGET_NUM }
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
  spacing = "\s" * ((BORDER.size - message.size) / 2)
  puts "#{BORDER}\n#{spacing + message}\n#{BORDER}"
end

def match_winner?(scores)
  scores.any? { |_, v| v == ROUNDS_TO_WIN }
end

def detect_match_winner(scores)
  scores.select { |_, v| v == ROUNDS_TO_WIN }.keys[0]
end

def display_match_winner(winner)
  message = "#{winner.capitalize} is the match winner!"
  spacing = "\s" * ((DOUBLE_BORDER.size - message.size) / 2)
  puts "#{DOUBLE_BORDER}\n#{spacing + message}\n#{DOUBLE_BORDER}"
end

def increment_score!(scores, winner)
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
  round = 1
  scores = { 'player' => 0, 'dealer' => 0 }

  loop do
    deck = initialize_deck
    player_hand, dealer_hand = deal_cards!(deck)
    totals = { 'player' => total(player_hand),
               'dealer' => total(dealer_hand) }

    player_turn!(player_hand, dealer_hand, deck, totals, scores)
    clear_screen

    unless busted?(totals['player'])
      dealer_turn!(dealer_hand, deck, totals)
    end

    increment_score!(scores, detect_round_winner(totals))
    display_scores(scores)
    display_hands(player_hand, dealer_hand, totals, true)
    display_round_winner(detect_round_winner(totals))

    break if match_winner?(scores)
    display_rounds_played(round)
    next_round_prompt
    round += 1
  end

  display_match_winner(detect_match_winner(scores))
  display_rounds_played(round)
  break unless play_again?
end

clear_screen
display_goodbye
