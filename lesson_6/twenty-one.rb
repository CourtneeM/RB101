# 1. Initialize deck
# 2. Deal cards to player and dealer
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
# used_cards: nested array that contains values from the deck nested array when
#             they are in the player or dealer hand [['D', '2'], ['H', 'J']]
# deck: nested array [['H', 5], ['C', 1], ['S', 'Q']]
# player cards: array (for aces, include [1, 11] and decide which one to use when needed)
# dealer cards: array  ^^^
