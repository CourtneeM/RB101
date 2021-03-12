require 'pry'

MATCHES_TO_WIN = 5
WIN_VALUE = 31
DEALER_HIT_UNTIL = 27

def prompt(message)
  puts(">> #{message}")
end

def clear_screen
  system('clear') || system('cls')
end

def join_and(arr)
  if arr.size == 2
    arr.join(' and ')
  else
    arr = arr.join(', ')
    arr.split.insert(-2, 'and').join(' ')
  end
end

def initialize_deck
  suits = ['H', 'D', 'C', 'S']
  numbers = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  suits.each_with_object([]) do |suit, deck|
    numbers.each { |number| deck.push([suit, number]) }
  end.shuffle
end

def deal_cards(deck)
  player_hand = []
  dealer_hand = []

  2.times do
    player_hand.push(deck.pop)
    dealer_hand.push(deck.pop)
  end

  [player_hand, dealer_hand]
end

def hit(deck, hand)
  hand.push(deck.pop)
end

def busted?(total_hand)
  total_hand > WIN_VALUE
end

def total(hand)
  values = hand.map { |card| card[1] }

  total = 0
  values.each do |value|
    total += 11 if value == 'A'
    total += 10 if ['J', 'Q', 'K'].include?(value)
    total += value.to_i
  end

  values.select { |value| value == 'A' }.count.times do
    total -= 10 if total > 21
  end

  total
end

def who_won?(totals)
  player_total, dealer_total = totals.values_at('player', 'dealer')

  if busted?(player_total) ||
     dealer_total >= player_total
    'dealer'
  elsif busted?(dealer_total) ||
        player_total > dealer_total
    'player'
  end
end

def display_round_winner(winner)
  case winner
  when 'dealer' then prompt("The dealer wins!")
  when 'player' then prompt("The player wins!")
  end
end

def display_match_winner(totals)
  if totals['player'] == 5
    prompt("Player is the match winner!")
  else
    prompt("Dealer is the match winner!")
  end
end

def increment(round_totals, winner)
  round_totals[winner] += 1
end

def player_turn(deck, player_hand, dealer_hand, totals)
  loop do
    p deck
    display_hands(player_hand, dealer_hand, totals)

    prompt("hit or stay?")
    answer = gets.chomp
    if answer == 'hit'
      hit(deck, player_hand)
      totals['player'] = total(player_hand)
    end

    clear_screen
    return if busted?(totals['player'])
    break if answer == 'stay'
  end

  prompt("You chose to stay!")
end

def dealer_turn(deck, dealer_hand, totals)
  player_total, dealer_total = totals.values_at('player', 'dealer')
  return if dealer_total > player_total

  loop do
    break if totals['dealer'] >= DEALER_HIT_UNTIL
    hit(deck, dealer_hand)
    totals['dealer'] = total(dealer_hand)
  end
end

def display_hands(player_hand, dealer_hand, totals, results = false)
  player_total, dealer_total = totals.values_at('player', 'dealer')
  royals = { 'J' => 'Jack', 'Q' => 'Queen', 'K' => 'King', 'A' => 'Ace' }

  player_cards = player_hand.map do |card|
    royals.keys.include?(card[1]) ? royals[card[1]] : card[1]
  end
  dealer_cards = dealer_hand.map do |card|
    royals.keys.include?(card[1]) ? royals[card[1]] : card[1]
  end

  puts "================================================================="
  if !results
    puts "Dealer has: #{dealer_cards[0]} and an unknown card"
  else
    puts "Dealer has: #{join_and(dealer_cards)} for a total of #{dealer_total}"
  end
  puts "You have: #{join_and(player_cards)} for a total of #{player_total}"
  puts "================================================================="
end

def display_rules
  prompt("Welcome to Twenty-One!")
  puts "--------------------------"
  prompt("Win #{MATCHES_TO_WIN} rounds to win the match.")
  prompt("Whoever has the highest amount without going over #{WIN_VALUE} is the round winner.")
  prompt("If it is a tie, the dealer wins.")
  prompt("Jack, Queen, King cards are worth 10. Ace are worth 1 or 11.")
end

def play_game
  round_totals = { 'player' => 0, 'dealer' => 0 }
  loop do
    deck = initialize_deck
    player_hand, dealer_hand = deal_cards(deck)
    totals = { 'player' => total(player_hand), 'dealer' => total(dealer_hand) }

    player_turn(deck, player_hand, dealer_hand, totals)
    if busted?(totals['player'])
      display_hands(player_hand, dealer_hand, totals)
      prompt("You busted! Dealer wins!")
      increment(round_totals, who_won?(totals))
      break display_match_winner(totals) if round_totals.values.include?(5)
      next
    else
      dealer_turn(deck, dealer_hand, totals)
      display_hands(player_hand, dealer_hand, totals, true)
    end

    if busted?(totals['dealer'])
      prompt("Dealer busted! You win!")
      increment(round_totals, who_won?(totals))
      break display_match_winner(totals) if round_totals.values.include?(5)
      next
    else
      display_round_winner(who_won?(totals))
      increment(round_totals, who_won?(totals))
    end

    break display_match_winner(totals) if round_totals.values.include?(5)
  end
end

def play_again?
  prompt("Do you want to play again? (yes or no)")
  answer = gets.chomp.downcase
  answer.start_with?('y')
end

loop do
  display_rules
  play_game
  break unless play_again?
  clear_screen
end
