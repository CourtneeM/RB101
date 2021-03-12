# 1. Initialize deck
#   - 13 cards per suit(4)
#   - create the deck by cycling through the suits and card numbers/faces
# 2. Deal cards to player and dealer
#   - remove the dealt cards from the deck
# ----------- above finished ----------------
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

# Flesh out the above pseudo-code a bit more

# Ace will be dynamically determined depending on the value of the rest of the cards in hand
# If the other cards total over 11, then ace is 1; if total is less than 11, then ace is 11

# Data Structures
# card_values: hash { '1' => 1, 'jack' => 10, 'ace': [1, 11] }
# deck: nested array [['H', 5], ['C', 1], ['S', 'Q']]
# player cards: array (for aces, include [1, 11] and decide which one to use when needed)
# dealer cards: array  ^^^
require 'pry'

MATCHES_TO_WIN = 5
WIN_VALUE = 21
DEALER_HIT_UNTIL = 17

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
  end
end

def deal_cards(deck)
  player_hand = deck.sample(2)
  remove_dealt_cards_from_deck!(deck, player_hand)

  dealer_hand = deck.sample(2)
  remove_dealt_cards_from_deck!(deck, dealer_hand)

  [player_hand, dealer_hand]
end

def remove_dealt_cards_from_deck!(deck, hand)
  hand.each { |card| deck.delete(card) }
end

def hit(deck, hand)
  hand.push(deck.sample)
  remove_dealt_cards_from_deck!(deck, hand)
end

def busted?(total_hand)
  total_hand > WIN_VALUE
end

def total(hand)
  total = 0
  aces = 0
  hand.map do |card|
    aces += 1 if card[1] == 'A'
    total += 10 if ['J', 'Q', 'K'].include?(card[1])
    total += card[1].to_i
  end

  aces_total = calculate_aces(total, aces)
  total += aces_total
end

def calculate_aces(total, aces)
  high_aces = aces
  low_aces = 0
  aces_total = 0

  loop do
    break aces_total if high_aces < 0

    aces_total = (high_aces * 11) + (low_aces * 1)
    if total + aces_total > WIN_VALUE
      high_aces -= 1
      low_aces += 1
    else
      break aces_total
    end
  end
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
    end

    display_hands(player_hand, dealer_hand, totals, true)
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
  answer == 'yes' || 'y'
end

loop do
  display_rules
  play_game
  break unless play_again?
  clear_screen
end
