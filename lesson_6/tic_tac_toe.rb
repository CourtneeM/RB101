INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
ROUNDS_TO_WIN = 5

def clear_screen
  system('clear') || system('cls')
end

def joinor(arr, separator = ', ', joining = 'or')
  if arr.size < 2
    arr.join
  elsif arr.size == 2
    "#{arr[0]} #{joining} #{arr[1]}"
  else
    arr = arr.join(separator)
    arr.split.insert(-2, joining).join(' ')
  end
end

def prompt(message)
  puts "=> #{message}"
end

def display_score(score)
  puts "Player: #{score['player']} | Computer: #{score['computer']}"
end

def display_board(board)
  clear_screen
  puts "You're an #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  (1..9).each_with_object({}) { |num, new_board| new_board[num] = INITIAL_MARKER }
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt("Choose a square (#{joinor(empty_squares(board))})")
    square = gets.chomp.to_i
    if empty_squares(board).include?(square)
      break
    else
      prompt("Sorry, that's not a valid choice.")
    end
  end
  board[square] = PLAYER_MARKER
end

def computer_places_piece!(board)
  square = empty_squares(board).sample
  board[square] = COMPUTER_MARKER
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won_round?(board)
  !!detect_round_winner(board)
end

def detect_round_winner(board)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  winning_lines.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def someone_won_match?(score)
  !!detect_match_winner(score)
end

def detect_match_winner(score)
  return 'Player' if score['player'] == ROUNDS_TO_WIN
  return 'Computer' if score['computer'] == ROUNDS_TO_WIN
end

def increment_score(score, winner)
  score[winner.downcase] += 1
end

loop do
  score = { 'player' => 0, 'computer' => 0 }
  loop do
    board = initialize_board
    display_board(board)

    loop do
      display_score(score)
      player_places_piece!(board)
      display_board(board)
      break if someone_won_round?(board) || board_full?(board)

      computer_places_piece!(board)
      display_board(board)
      break if someone_won_round?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won_round?(board)
      prompt("#{detect_round_winner(board)} won!")
      increment_score(score, detect_round_winner(board))
      display_score(score)
    else
      prompt("It's a tie!")
    end

    if someone_won_match?(score)
      puts "============================"
      puts "#{detect_match_winner(score)} is the match winner!"
      break
    end
  end

  prompt("Play again? (y or n)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing Tic Tac Toe. Goodbye!")
