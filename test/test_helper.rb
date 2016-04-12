require 'minitest/autorun'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

def create_first_solution
  Q8::Board.from_string('a8,b2,c4,d1,e7,f5,g3,h6')
end

def create_other_solution
  brd = Q8::Board.new

  #   a b c d e f g h
  # 8 . . . Q . . . .
  # 7 . . . . . . Q .
  # 6 . . Q . . . . .
  # 5 . . . . . . . Q
  # 4 . Q . . . . . .
  # 3 . . . . Q . . .
  # 2 Q . . . . . . .
  # 1 . . . . . Q . .

  brd.board[0][3] = brd.board[1][6] = Q8::QFILL_CELL
  brd.board[2][2] = brd.board[3][7] = Q8::QFILL_CELL
  brd.board[4][1] = brd.board[5][4] = Q8::QFILL_CELL
  brd.board[6][0] = brd.board[7][5] = Q8::QFILL_CELL
  brd
end


# def create_third_solution
#   board_from_s('a2,b4,c6,d8,e3,f1,g7,h5')
# end
