MOVES = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'spock' => ['rock', 'scissors'],
  'lizard' => ['paper', 'spock']
}

ABBR = ['r', 'p', 'sc', 'sp', 'l']

def prompt(message)
  puts "=> #{message}"
end

def play_round(score)
  choice = player_choice
  computer_choice = MOVES.keys.sample

  display_round_choices(choice, computer_choice)
  update_score(choice, computer_choice, score)
  display_results(choice, computer_choice)
  display_current_score(score)
end

def player_choice
  loop do
    prompt("Choose one: #{MOVES.keys.join(', ')}.")
    choice = gets.chomp

    if valid_player_choice?(choice)
      choice = MOVES.keys.select { |key| key.start_with?(choice) }.join
      return choice
    else
      prompt("That's not a valid choice.")
    end
  end
end

def valid_player_choice?(choice)
  MOVES.keys.include?(choice) ||
    ABBR.include?(choice)
end

def win?(first, second)
  MOVES[first].include?(second)
end

def update_score(choice, computer_choice, score)
  if win?(choice, computer_choice)
    score[:player] += 1
  elsif win?(computer_choice, choice)
    score[:computer] += 1
  end
end

def play_again?
  prompt("---------------------------------")
  prompt("Do you want to play again?")

  loop do
    prompt("Yes to play again, No to exit.")
    answer = gets.chomp

    case answer.downcase
    when 'y', 'yes' then return true
    when 'n', 'no' then return false
    else prompt("That isn't a valid choice.")
    end
  end
end

def display_round_choices(choice, computer_choice)
  prompt("You chose: #{choice}. Computer chose: #{computer_choice}.")
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def display_current_score(score)
  prompt("Player: #{score[:player]} | Computer: #{score[:computer]}")
end

def display_grand_winner(score)
  if score[:player] == 5
    prompt("Congrats, you are the grand winner!")
  else
    prompt("The computer is the grand winner!")
  end
end

def display_welcome_message
  prompt("Welcome to Rock, Paper, Scissors, Spock, Lizard!")
  prompt("Whoever wins 5 rounds will be the grand winner. Good luck!")
  prompt("----------------------------------------------------------")
end

def display_goodbye_message
  prompt("Thank you for playing. Goodbye!")
end

def clear_screen
  system("cls") || system("clear")
end

display_welcome_message

loop do
  score = { player: 0, computer: 0 }

  until score[:player] == 5 || score[:computer] == 5
    play_round(score)
  end

  display_grand_winner(score)
  break unless play_again?

  clear_screen
end

display_goodbye_message
