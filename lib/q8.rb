module Q8
  BOARD_SIZE = 8
  EMPTY_CELL = '.'
  QFILL_CELL = 'Q'
  MAX_INDEX = BOARD_SIZE - 1
end

def new_board
  board = []
  Q8::BOARD_SIZE.times do
    board << [Q8::EMPTY_CELL] * Q8::BOARD_SIZE
  end
  board
end

def debug_board(board)
  puts "==== BOARD ==="
  Q8::BOARD_SIZE.times do |r|
    puts board[r].join(' ')
  end
end

def board_to_s(board)
  letters = 'abcdefgh'.chars
  qq = {}

  board.each_with_index.map do |r, i|
    q = r.index(Q8::QFILL_CELL)
    format("%s%d", letters[q], Q8::BOARD_SIZE - i)
  end.sort.join(',')
end

def board_from_s(str)
  board = new_board

  letters = 'abcdefgh'.chars
  qs = []

  str.gsub(' ', '').split(',').each do |pair|
    qs[Q8::BOARD_SIZE - pair[1].to_i] = letters.index(pair[0])
  end

  qs.each_with_index do |c, r|
    board[r][c] = Q8::QFILL_CELL
  end

  board
end

def valid_board?(board, r, c)

  for ci in c.times
    return false if board[r][ci] == Q8::QFILL_CELL
  end

  for ri in r.times
    return false if board[ri][c] == Q8::QFILL_CELL
  end

  ri = r - 1
  ci = c - 1
  while (ri > -1 && ci > -1)
    return false if board[ri][ci] == Q8::QFILL_CELL
    ri -= 1
    ci -= 1
  end

  ri = r - 1
  ci = c + 1
  while (ri > -1 && ci < Q8::BOARD_SIZE)
    return false if board[ri][ci] == Q8::QFILL_CELL
    ri -= 1
    ci += 1
  end

  true
end

def find_solution
  board = new_board()

  r = 0
  c = 0

  while(true)
    if (r == Q8::BOARD_SIZE)
      return board
    end

    if(c == Q8::BOARD_SIZE)
      unless board[r].index(Q8::QFILL_CELL)
        r -= 1
        c = board[r].index(Q8::QFILL_CELL)
        board[r][c] = Q8::EMPTY_CELL
        c +=1
      else
        c = 0
        r +=1
      end
      next
    end

    if(valid_board?(board, r, c))
      board[r][c] = Q8::QFILL_CELL
      r+=1
      c = 0
    else
      c += 1
    end
  end

  return board
end

def fill_row(r, board)
  Q8::BOARD_SIZE.times do |c|
    # puts "fill_row r: #{r}, c: #{c}"
    if valid_board?(board, r, c)
      board[r][c] = Q8::QFILL_CELL

      return true if r == Q8::MAX_INDEX
      return true if fill_row(r + 1, board)

      board[r][c] = Q8::EMPTY_CELL
    end
  end
  return false
end


def fill_row_up(r, board)
  return false if r < 0

  q = board[r].index(Q8::QFILL_CELL)
  board[r][q] = Q8::EMPTY_CELL

  for c in (q+1..Q8::MAX_INDEX)
    if valid_board?(board, r, c)
      board[r][c] = Q8::QFILL_CELL

      return true if r == Q8::MAX_INDEX
      return true if fill_row(r + 1, board)
      board[r][c] = Q8::EMPTY_CELL
    end
  end

  return false if r == 0
  return fill_row_up(r - 1, board)
end

def find_solution_rec
  board = new_board()
  fill_row(0, board)
  board
end

def each_solution
  board = find_solution
  i = 0
  begin
    yield board.clone
    i += 1
  end while(fill_row_up(Q8::MAX_INDEX, board))
  i
end

