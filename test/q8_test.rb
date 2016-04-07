require 'test_helper'
require File.expand_path("./lib/q8.rb")

class TestQ8 < MiniTest::Unit::TestCase
  def setup
    @test_brd = create_other_solution
  end

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

    brd.rows[0][3] = brd.rows[1][6] = Q8::QFILL_CELL
    brd.rows[2][2] = brd.rows[3][7] = Q8::QFILL_CELL
    brd.rows[4][1] = brd.rows[5][4] = Q8::QFILL_CELL
    brd.rows[6][0] = brd.rows[7][5] = Q8::QFILL_CELL
    brd
  end


  # def create_third_solution
  #   board_from_s('a2,b4,c6,d8,e3,f1,g7,h5')
  # end

  def test_new_board
    brd = Q8::Board.new

    assert_equal brd.size, Q8::BOARD_SIZE
    assert_equal brd.rows.first.size, Q8::BOARD_SIZE
  end

  def test_clone
    brd = Q8::Board.new
    brd.queen(5, 5)

    brd_clone = brd.clone

    assert_equal brd, brd_clone
    assert_equal brd.board, brd_clone.board
    assert brd.object_id != brd_clone.object_id
  end

  def test_board_to_s
    brd = create_other_solution

    assert_equal 'a2,b4,c6,d8,e3,f1,g7,h5', brd.to_s
  end

  def test_board_from_s
    brd = create_other_solution

    assert_equal Q8::Board.from_string('a2,b4,c6,d8,e3,f1,g7,h5'), brd
    assert_equal Q8::Board.from_string('a2, b4, c6, d8, e3, f1, g7, h5'), brd
  end

  def test_board_valid?
    brd = Q8::Board.new
    brd.queen(0, 0)

    assert_equal brd.valid?(7, 7), false
    assert_equal brd.valid?(0, 7), false
    assert_equal brd.valid?(7, 0), false
    assert_equal brd.valid?(2, 3), true
    assert_equal brd.valid?(3, 2), true
  end

  def test_find_solution_rec
    solution = create_first_solution
    res =  Q8::Solver.new.find_first

    assert_equal solution, res
  end

  def test_each_solution
    i = 0
    count = Q8::Solver.new.find_all do |s|
      i += 1
    end

    assert_equal 92, count
  end
end