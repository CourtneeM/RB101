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
  break unless play_again?
end

prompt("Thanks for playing! Goodbye.")
