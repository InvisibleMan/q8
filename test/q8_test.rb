require 'test_helper'
require File.expand_path("./lib/q8.rb")

class TestMeme < MiniTest::Unit::TestCase
  def setup
  end

  def test_new_board
    board = new_board()
    assert_equal board.size, Q8::BOARD_SIZE
    assert_equal board.first.size, Q8::BOARD_SIZE
  end

  def test_valid_board_2
    board = new_board()
    board[0][0] = Q8::QFILL_CELL
    board[7][7] = Q8::QFILL_CELL
    assert_equal valid_board?(board, 7, 7), false
  end

  def create_first_solution
    board = new_board()
    board[0][0] = board[1][4] = Q8::QFILL_CELL
    board[2][7] = board[3][5] = Q8::QFILL_CELL
    board[4][2] = board[5][6] = Q8::QFILL_CELL
    board[6][1] = board[7][3] = Q8::QFILL_CELL
    board
  end

  def create_other_solution
    #   a b c d e f g h
    # 8 . . . Q . . . .
    # 7 . . . . . . Q .
    # 6 . . Q . . . . .
    # 5 . . . . . . . Q
    # 4 . Q . . . . . .
    # 3 . . . . Q . . .
    # 2 Q . . . . . . .
    # 1 . . . . . Q . .

    board = new_board()
    board[0][3] = board[1][6] = Q8::QFILL_CELL
    board[2][2] = board[3][7] = Q8::QFILL_CELL
    board[4][1] = board[5][4] = Q8::QFILL_CELL
    board[6][0] = board[7][5] = Q8::QFILL_CELL
    board
  end

  def create_third_solution
    board_from_s('a2,b4,c6,d8,e3,f1,g7,h5')
  end

  # def test_find_solution_rec
  #   skip "test this later"
  #   solution = create_first_solution
  #   res = find_solution_rec
  #   res = find_solution
  #   puts "\nRESULT"
  #   # debug_board(res)
  #   # debug_board(solution)

  #   assert_equal solution, res
  # end

  def test_each_solution
    # skip "test this later"
    i = 0
    count = each_solution do |s|
      i += 1
    end
    assert_equal 92, count
  end

  def test_board_to_s
    board = create_other_solution

    assert_equal 'a2,b4,c6,d8,e3,f1,g7,h5', board_to_s(board)
  end

  def test_board_from_s
    board = create_other_solution

    assert_equal board_from_s('a2,b4,c6,d8,e3,f1,g7,h5'), board
    assert_equal board_from_s('a2, b4, c6, d8, e3, f1, g7, h5'), board
  end

  def test_find_new_solution
    board = create_third_solution

    next_board = fill_row_up(Q8::MAX_INDEX, board)

    assert_equal true, next_board
  end
end