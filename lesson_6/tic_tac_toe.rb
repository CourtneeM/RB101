require 'pry'

WHO_FIRST = 'player'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]
ROUNDS_TO_WIN = 5

def prompt(message)
  puts ">> #{message}"
end

def clear_screen
  system('cls') || system('clear')
end

def joinor(arr, separator = ', ', joining = 'or')
  if arr.size < 2
    arr.join
  elsif arr.size == 2
    arr.join(' or ')
  else
    arr = arr.join(separator)
    arr.split.insert(-2, joining).join(' ')
  end
end

def display_rules
  clear_screen
  prompt("First to 5 wins is the winner!")
end

def display_board(brd)
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt("Sorry, that's not a valid choice.")
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_danger_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  if !square
    WINNING_LINES.each do |line|
      square = find_danger_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square
    square = 5 if brd[5] == INITIAL_MARKER
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def find_danger_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def player_first(board, score)
  loop do
    display_board(board)
    display_score(score)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end
end

def computer_first(board, score)
  loop do
    display_board(board)
    display_score(score)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def detect_grand_winner(score)
  score.values.any?(ROUNDS_TO_WIN)
end

def display_grand_winner(score)
  winner = score.select { |_, v| v == ROUNDS_TO_WIN }
  prompt("#{winner.keys.join.capitalize} is the grand winner!")
  puts "------------------------------"
end

def increment_score(score, winner)
  score[winner.downcase] += 1
end

def display_score(score)
  puts "Player: #{score['player']} | Computer: #{score['computer']}"
end

loop do
  score = { 'player' => 0, 'computer' => 0 }
  display_rules

  loop do
    board = initialize_board

    if WHO_FIRST == 'player'
      player_first(board, score)
    elsif WHO_FIRST == 'computer'
      computer_first(board, score)
    elsif WHO_FIRST == 'choose'
      prompt("Should the player or computer go first?")
      prompt("(Type 'player' or 'computer')")
      answer = gets.chomp.downcase

      case answer
      when 'player' then player_first(board, score)
      when 'computer' then computer_first(board, score)
      end
    else
      player_first(board, score)
    end

    clear_screen
    if someone_won?(board)
      prompt("#{detect_winner(board)} won!")
      increment_score(score, detect_winner(board))
    else
      prompt("It's a tie!")
    end

    display_score(score)
    display_board(board)

    break if detect_grand_winner(score)
  end

  display_grand_winner(score)

  prompt("Play again? (y or n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

# fix display of score / clearing screen
