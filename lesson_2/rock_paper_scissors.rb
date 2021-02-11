VALID_CHOICES = %w[rock paper scissors lizard spock]

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'spock' && second == 'rock') ||
    (first == 'spock' && second == 'scissors')
end

def abbr_choice_to_choice(choice)
  VALID_CHOICES.select do |valid_choice|
    if valid_choice.start_with?('s')
      valid_choice.start_with?(choice[0..1].downcase)
    else
      valid_choice.start_with?(choice.downcase)
    end
  end.join
end

def who_won?(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'tie'
  end
end

def increment_win(round_result, score)
  if round_result == 'player'
    score[:player] += 1
  elsif round_result == 'computer'
    score[:computer] += 1
  end
  score
end

def check_for_winner(score)
  score[:player] == 5 || score[:computer] == 5
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

def display_grand_winner(score)
  if score[:player] == 5
    prompt("You're the grand winner!")
  elsif score[:computer] == 5
    prompt("The computer is the grand winner!")
  end
end

def display_current_scores(score)
  prompt("Player wins: #{score[:player]} | Computer wins: #{score[:computer]}")
end

loop do
  score = { player: 0, computer: 0 }

  loop do
    choice = ''

    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = gets.chomp
      choice = abbr_choice_to_choice(choice) if !VALID_CHOICES.include?(choice)

      if VALID_CHOICES.include?(choice.downcase)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample
    score = increment_win(who_won?(choice, computer_choice), score)

    prompt("You chose: #{choice}. Computer chose: #{computer_choice}")
    display_results(choice, computer_choice)
    display_current_scores(score)

    break if check_for_winner(score)
  end

  display_grand_winner(score)
  prompt("Do you want to play again?")
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing. Goodbye!")
