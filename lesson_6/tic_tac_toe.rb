FIRST_MOVE = 'player'
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
ROUNDS_TO_WIN = 5
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]

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

def display_round(round)
  clear_screen
  puts "Round ##{round}"
end

def display_score(score)
  puts "[Player: #{score['player']} | Computer: #{score['computer']}]" \
       " (First to #{ROUNDS_TO_WIN} wins)"
end

def display_board(board)
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

def display_info(round, board)
  display_round(round)
  display_board(board)
end

def next_round_prompt
  puts "==================================="
  prompt("Press enter to start next round.")
  gets.chomp
end

def initialize_board
  (1..9).each_with_object({}) do |num, new_board|
    new_board[num] = INITIAL_MARKER
  end
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def alternate_player(current_player)
  case current_player
  when 'player'   then 'computer'
  when 'computer' then 'player'
  end
end

def place_piece!(board, current_player)
  case current_player
  when 'player'   then player_places_piece!(board)
  when 'computer' then computer_places_piece!(board)
  end
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
  square = find_danger_square(board, COMPUTER_MARKER)
  square = find_danger_square(board, PLAYER_MARKER) if !square
  square = 5 if !square && board[5] == INITIAL_MARKER
  square = empty_squares(board).sample if !square
  board[square] = COMPUTER_MARKER
end

def find_danger_square(board, marker)
  danger_squares = []
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(marker) == 2
      danger_squares << line.select { |num| board[num] == INITIAL_MARKER }
    end
  end
  danger_squares = danger_squares.reject(&:empty?)
  danger_squares.empty? ? nil : danger_squares.sample.join.to_i
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won_round?(board)
  !!detect_round_winner(board)
end

def detect_round_winner(board)
  WINNING_LINES.each do |line|
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

def who_goes_first?
  loop do
    clear_screen
    prompt("Who should go first? (player or computer)")
    first_player = gets.chomp
    if first_player == 'player' || first_player == 'computer'
      return first_player
    end
  end
end

def play_round(round, score, board, current_player)
  loop do
    display_info(round, board)
    display_score(score)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won_round?(board) || board_full?(board)
  end
end

def round_end(score, board)
  if someone_won_round?(board)
    prompt("#{detect_round_winner(board)} won!")
    increment_score(score, detect_round_winner(board))
    display_score(score)
  else
    prompt("It's a tie!")
  end
end

def play_again?
  loop do
    prompt("Play again? (y or n)")
    answer = gets.chomp
    if answer == 'yes' || answer == 'y'
      return answer
    elsif answer == 'no' || answer == 'n'
      return false
    end
    prompt("Please input a valid answer.")
  end
end

loop do
  score = { 'player' => 0, 'computer' => 0 }
  round = 1
  first_player = FIRST_MOVE

  loop do
    board = initialize_board
    current_player = first_player

    if current_player == 'player' || current_player == 'computer'
      play_round(round, score, board, current_player)
    elsif current_player == 'choose'
      first_player = who_goes_first?
      next
    end

    display_info(round, board)
    round_end(score, board)

    if someone_won_match?(score)
      puts "=============================="
      puts "#{detect_match_winner(score)} is the match winner!"
      break
    end

    round += 1
    next_round_prompt
  end

  break unless play_again?
end

prompt("Thanks for playing Tic Tac Toe. Goodbye!")
