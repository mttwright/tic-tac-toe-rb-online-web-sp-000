WIN_COMBINATIONS = [
    [0, 1, 2],
    [0, 3, 6],
    [3, 4, 5],
    [2, 4, 6],
    [6, 7, 8],
    [0, 4, 8],
    [1, 4, 7],
    [2, 5, 8]
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end
  
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index > 8 || index < 0
    false
  elsif position_taken?(board, index)
    false
  else
    true
  end
end

def turn_count(board)
  counter = 0
  board.each do |x|
    if x == "X" || x == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def move(board, index, symbol)
  if valid_move?(board, index)
    board[index] = symbol
  else
    "Error!"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  input = input_to_index(input)
  if valid_move?(board, input)
    current_player = current_player(board)
    move(board, input, current_player)
  else
    puts "Please enter 1-9:"
    turn(board)
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
  
  if draw?(board)
    puts "Cat's Game!"
  end
end
  
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    win_index_1 = win_combo[0]
    win_index_2 = win_combo[1]
    win_index_3 = win_combo[2]
    
    pos_1 = board[win_index_1]
    pos_2 = board[win_index_2]
    pos_3 = board[win_index_3]
    
    if pos_1 == "X" && pos_2 == "X" && pos_3 == "X"
      return win_combo
    end
    
    if pos_1 == "O" && pos_2 == "O" && pos_3 == "O"
      return win_combo
    end
  end
  false
end

def full?(board)
  counter = 0
  board.each do |x|
    if x == "X" || x == "O"
      counter += 1
    end
  end
  if counter == 9
    true
  else
    false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board) || won?(board) || (won?(board) && full?(board))
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    a = won?(board)
    a = a[0]
    winner = board[a]
  else
    nil
  end
end