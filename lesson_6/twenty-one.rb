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
  deck = []

  suits.each do |suit|
    numbers.each do |number|
      deck.push([suit, number])
    end
  end
  deck
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

def busted?(hand)
  hand_total(hand) > 21
end

def hand_total(hand)
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
    if total + aces_total > 21
      high_aces -= 1
      low_aces += 1
    else
      break aces_total
    end
  end
end

def who_won?(player_hand, dealer_hand)
  if busted?(player_hand) ||
     hand_total(dealer_hand) >= hand_total(player_hand)
    'dealer'
  elsif busted?(dealer_hand) ||
        hand_total(player_hand) > hand_total(dealer_hand)
    'player'
  end
end

def declare_winner(winner)
  case winner
  when 'dealer' then prompt("The dealer wins!")
  when 'player' then prompt("The player wins!")
  end
end

def player_turn(deck, player_hand, dealer_hand)
  loop do
    display_hands(player_hand, dealer_hand)

    prompt("hit or stay?")
    answer = gets.chomp
    if answer == 'hit'
      hit(deck, player_hand)
    end

    clear_screen
    return if busted?(player_hand)
    break if answer == 'stay'
  end

  prompt("You chose to stay!")
end

def dealer_turn(deck, dealer_hand, player_hand)
  return if hand_total(dealer_hand) > hand_total(player_hand)

  loop do
    break if hand_total(dealer_hand) >= 17
    hit(deck, dealer_hand)
  end
end

def display_hands(player_hand, dealer_hand, results = false)
  royals = { 'J' => 'Jack', 'Q' => 'Queen', 'K' => 'King', 'A' => 'Ace' }
  player_cards = player_hand.map do |card|
    royals.keys.include?(card[1]) ? royals[card[1]] : card[1]
  end
  dealer_cards = dealer_hand.map do |card|
    royals.keys.include?(card[1]) ? royals[card[1]] : card[1]
  end

  if !results
    puts "Dealer has: #{dealer_cards[0]} and an unknown card"
  else
    puts "Dealer has: #{join_and(dealer_cards)}"
  end
  puts "You have: #{join_and(player_cards)}"
end

def display_rules
  prompt("Whoever has the highest amount without going over 21 is the winner.")
  prompt("If it is a tie, the dealer wins.")
  prompt("Jack, Queen, King cards are worth 10. Ace are worth 1 or 11.")
  puts "------------------------------------------------------------------"
end

def play_game
  deck = initialize_deck
  player_hand, dealer_hand = deal_cards(deck)

  player_turn(deck, player_hand, dealer_hand)
  if busted?(player_hand)
    display_hands(player_hand, dealer_hand)
    return prompt("You busted! Dealer wins!")
  else
    dealer_turn(deck, dealer_hand, player_hand)
  end

  display_hands(player_hand, dealer_hand, true)
  if busted?(dealer_hand)
    prompt("Dealer busted! You win!")
  else
    declare_winner(who_won?(player_hand, dealer_hand))
  end
end

def play_again?
  puts "-----------------------------------------"
  prompt("Do you want to play again? (yes or no)")
  answer = gets.chomp.downcase
  answer == 'yes'
end

loop do
  display_rules
  play_game
  break unless play_again?
  clear_screen
end
