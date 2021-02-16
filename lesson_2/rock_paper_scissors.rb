VALID_CHOICES = %w(rock paper scissors spock lizard)
WINNING_MOVES = {
  'rock' => ['scissors', 'lizard'],
  'paper' => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'spock' => ['rock', 'scissors'],
  'lizard' => ['paper', 'spock']
}

def prompt(message)
  puts "=> #{message}"
end

def player_choice
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}.")
    choice = gets.chomp

    if VALID_CHOICES.include?(choice)
      return choice
    else
      prompt("That's not a valid choice.")
    end
  end
end

def win?(first, second)
  WINNING_MOVES[first].include?(second)
end

def play_again?
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

def display_welcome_message
  prompt("Welcome to Rock, Paper, Scissors, Spock, Lizard!")
  prompt("Whoever wins 5 rounds will be the grand winner. Good luck!")
  prompt("----------------------------------------------------------")
end

def display_goodbye_message
  prompt("Thank you for playing. Goodbye!")
end

display_welcome_message

loop do
  choice = player_choice
  computer_choice = VALID_CHOICES.sample

  display_round_choices(choice, computer_choice)
  display_results(choice, computer_choice)

  break unless play_again?
end

display_goodbye_message
