require 'minitest/autorun'
require 'minitest/reporters'

require File.expand_path("main.rb")

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

class TestMeme < MiniTest::Unit::TestCase
  def setup
    # @meme = Meme.new
  end

  # def test_that_kitty_can_eat
  #   assert_equal "OHAI!", @meme.i_can_has_cheezburger?
  # end

  # def test_that_it_will_not_blend
  #   refute_match /^no/i, @meme.will_it_blend?
  # end

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

  def test_find_solution_rec
    solution = create_first_solution
    res = find_solution_rec
    res = find_solution
    puts "\nRESULT"
    debug_board(res)
    # debug_board(solution)

    assert_equal solution, res
  end



  # def test_find_solution
  #   board = create_first_solution

  # end

  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end