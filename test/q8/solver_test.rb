require 'test_helper'
require File.expand_path("./lib/q8.rb")

class TestQ8 < MiniTest::Unit::TestCase
  def setup
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