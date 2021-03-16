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

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts "=> #{message}"
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

def player_turn(player_hand, deck, totals)
  loop do
    prompt("Hit or stay?")
    answer = gets.chomp # validate
    player_hand << deck.pop
    totals['player'] = get_total(player_hand)
    # display hand and total
    break if answer == 'stay' #|| busted?
  end

  # if busted?
  #   play_again?
  # else
  #   puts "You chose to stay!"
  # end
end

# def dealer_turn(dealer_hand)

# end

def get_total(hand) # need to handle royals
  values = hand.map { |card| card[1].to_i }
  values.sum
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
  deck = initialize_deck
  player_hand, dealer_hand = deal_cards(deck)
  totals = { 'player' => get_total(player_hand),
             'dealer' => get_total(dealer_hand) }

  player_turn(player_hand, deck, totals)
  p totals

  break unless play_again?
end

prompt("Thanks for playing! Goodbye.")
