require 'pry'

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
  filled_squares = WINNING_LINES.map do |sub_arr|
    sub_arr.reject { |num| empty_squares(brd).include?(num) }
  end

  danger = filled_squares.select do |sub_arr|
    next false if sub_arr.size == 3
    brd[sub_arr[0]] == PLAYER_MARKER && brd[sub_arr[1]] == PLAYER_MARKER
  end

  if !danger.empty?
    square = 0
    selected_danger_line = danger.sample
    WINNING_LINES.map do |line|
      if line.include?(selected_danger_line[0]) &&
         line.include?(selected_danger_line[1])
        square = (line + selected_danger_line).tally.select { |_, v| v == 1 }.keys[0]
      end
    end
  else
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
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

    loop do
      display_board(board)
      display_score(score)
      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
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
