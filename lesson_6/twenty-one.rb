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

CARD_VALUES = { '1' => 1, '2' => 2, '3' => 3, '4' => 4, '5' => 5,
                '6' => 6, '7' => 7, '8' => 8, '9' => 9, '10' => 10,
                'J' => 10, 'Q' => 10, 'K' => 10, 'A' => [1, 11] }

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

deck = initialize_deck
player_hand, dealer_hand = deal_cards(deck)
p player_hand
p dealer_hand
