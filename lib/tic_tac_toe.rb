WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(move)
  move.to_i - 1
end

def move(board, move, char)
  board[move] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
 if index.between?(0, 8) && !position_taken?(board, index)
   true
 else
   false
 end
end

def won?(board)
count = 0
  until count > 7 do
  #use count as a selecter for index of WIN_COMBINATIONS
   win_array = WIN_COMBINATIONS[count]
   board_array = []
  #retrieve indexes from board that correspond to WIN_COMBINATIONS[i]
    win_array.each do |index|
      board_array << board[index]
    end
  #if all x or o then game over (break)
  if board_array == ["X", "X", "X"] || board_array == ["O", "O", "O"]
    return win_array
  else
    #else reset board_array and increase count and try again
      board_array = []
      count += 1
  end
  end
end

def full?(board)
  emptys = board.detect do |index|
           index == "" || index == " "
         end
  if emptys != nil
    return false
  else
    return true
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  end
end

def winner(board)
  if won?(board) == nil
    return nil
  end
  board[won?(board)[0]]
end

def turn(board)
 loop do
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
     break
    end
  end
 display_board(board)
end

# Define your play method below
def play(board)
 until over?(board)
  turn(board)
 end
 if won?(board)
   puts "Congratulations #{winner(board)}!"
 elsif draw?(board)
   puts "Cat's Game!"
 end
end

def turn_count(board)
  moves_so_far = board.select do |element|
                    element == "X" || element == "O"
                  end
    moves_so_far.length
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end
