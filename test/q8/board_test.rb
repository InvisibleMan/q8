require 'test_helper'
require File.expand_path("./lib/q8.rb")

class TestBoard < MiniTest::Unit::TestCase
  def setup
    @test_brd = create_other_solution
  end

  def test_new_board
    brd = Q8::Board.new

    assert_equal brd.size, Q8::BOARD_SIZE
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
    assert_equal 'a2,b4,c6,d8,e3,f1,g7,h5', @test_brd.to_s
  end

  def test_board_from_s
    assert_equal Q8::Board.from_string('a2,b4,c6,d8,e3,f1,g7,h5'), @test_brd
    assert_equal Q8::Board.from_string('a2, b4, c6, d8, e3, f1, g7, h5'), @test_brd
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
end