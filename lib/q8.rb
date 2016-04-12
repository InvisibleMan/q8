module Q8
  BOARD_SIZE = 8
  EMPTY_CELL = '.'
  QFILL_CELL = 'Q'
  MAX_INDEX = BOARD_SIZE - 1
end

require './lib/q8/board.rb'
require './lib/q8/solver.rb'

def debug_board(board)
  puts "==== BOARD ==="
  Q8::BOARD_SIZE.times do |r|
    puts board[r].join(' ')
  end
end
