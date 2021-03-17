# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

# Data Structures
# - deck: nested array [['H', '2'], ['C', 'A'], ['S', '9']]
# - player / dealer cards: array

require 'pry'

TARGET_NUM = 21
DEALER_HIT_UNTIL = 17

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts "=> #{message}"
end

def display_welcome
  prompt("Welcome to Twenty-One!")
  prompt("Closest to #{TARGET_NUM} without going over wins.")
  puts "========================================="
end

def display_hands(player_hand, dealer_hand, totals, results = false)
  player_values = values(player_hand)
  dealer_values = values(dealer_hand)

  case results
  when true
    puts "Dealer has: #{dealer_values.join(', ')} for a total of #{totals['dealer']}"
  when false
    puts "Dealer has: #{dealer_values[0]} and unknown card"
  end
  puts "You have: #{player_values.join(', ')} for a total of #{totals['player']}"
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

def player_turn(player_hand, dealer_hand, deck, totals)
  totals['player'] = total(values(player_hand))
  loop do
    display_hands(player_hand, dealer_hand, totals)

    case hit_or_stay
    when :hit
      hit(player_hand, deck, totals, 'player')
      break if busted?(totals, 'player')
    when :stay
      break
    end
  end

  busted?(totals, 'player') ? play_again? : puts("You chose to stay!") # needs fix
end

def dealer_turn(dealer_hand, player_hand, deck, totals)
  totals['dealer'] = total(values(dealer_hand))
  loop do
    break if totals['dealer'] >= DEALER_HIT_UNTIL || busted?(totals, 'dealer')
    hit(dealer_hand, deck, totals, 'dealer')
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

def hit(hand, deck, totals, current_player)
  hand << deck.pop
  totals[current_player] = total(values(hand))
end

def busted?(totals, current_player) # fix
  totals[current_player] > 21
end

def detect_winner(totals)
  player_total, dealer_total = totals.values_at('player', 'dealer')
  if player_total > dealer_total && !busted?(totals, 'player')
    :player
  elsif dealer_total > player_total && !busted?(totals, 'dealer')
    :dealer
  end
end

def display_winner(winner)
  case winner
  when :player then puts "You won!"
  when :dealer then puts "Dealer won!"
  end
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

  deck = initialize_deck
  player_hand, dealer_hand = deal_cards(deck)
  totals = { 'player' => 0,
             'dealer' => 0 }

  player_turn(player_hand, dealer_hand, deck, totals)
  dealer_turn(dealer_hand, player_hand, deck, totals)
  display_hands(player_hand, dealer_hand, totals, true)
  display_winner(detect_winner(totals))

  break unless play_again?
end

prompt("Thanks for playing! Goodbye.")


# what to do when busted?
