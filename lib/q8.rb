module Q8
  BOARD_SIZE = 8
  EMPTY_CELL = '.'
  QFILL_CELL = 'Q'
  MAX_INDEX = BOARD_SIZE - 1


  class Board
    attr_reader :board

    def initialize
      @board = []
      Q8::BOARD_SIZE.times do
        @board << [Q8::EMPTY_CELL] * Q8::BOARD_SIZE
      end
    end

    def size
      @board.size
    end

    def rows
      @board
    end

    def to_s
      letters = 'abcdefgh'.chars
      qq = {}

      @board.each_with_index.map do |r, i|
        q = r.index(Q8::QFILL_CELL)
        format("%s%d", letters[q], Q8::BOARD_SIZE - i)
      end.sort.join(',')
    end

    def self.from_string(str)
      brd = Board.new

      letters = 'abcdefgh'.chars
      qs = []

      str.gsub(' ', '').split(',').each do |pair|
        qs[Q8::BOARD_SIZE - pair[1].to_i] = letters.index(pair[0])
      end

      qs.each_with_index do |c, r|
        brd.board[r][c] = Q8::QFILL_CELL
      end

      brd
    end

    def ==(rhs)
      @board == rhs.board
    end
    
    def valid?(r, c)

      for ci in c.times
        return false if @board[r][ci] == Q8::QFILL_CELL
      end

      for ri in r.times
        return false if @board[ri][c] == Q8::QFILL_CELL
      end

      ri = r - 1
      ci = c - 1
      while (ri > -1 && ci > -1)
        return false if @board[ri][ci] == Q8::QFILL_CELL
        ri -= 1
        ci -= 1
      end

      ri = r - 1
      ci = c + 1
      while (ri > -1 && ci < Q8::BOARD_SIZE)
        return false if @board[ri][ci] == Q8::QFILL_CELL
        ri -= 1
        ci += 1
      end

      true
    end

    def cell(r, c, val)
      @board[r][c] = val
    end

    def queen(r, c)
      cell(r, c, Q8::QFILL_CELL)
    end

    def empty(r, c)
      cell(r, c, Q8::EMPTY_CELL)
    end 

    def clone
      brd = Board.new

      brd.size.times do |r|
        brd.size.times do |c|
          brd.cell(r, c, @board[r][c])
        end
      end

      brd
    end

    def queen_index(r)
      @board[r].index(Q8::QFILL_CELL)
    end

  end

  class Solver
    def fill_row_down(r, brd)
      brd.size.times do |c|
        if brd.valid?(r, c)
          brd.queen(r, c)

          return true if r == brd.size - 1
          return true if fill_row_down(r + 1, brd)

          brd.empty(r, c)
        end
      end
      false
    end

    def find_first
      brd = Q8::Board.new
      fill_row_down(0, brd)
      brd
    end

    def fill_row_up(r, brd)
      return false if r < 0

      q = brd.queen_index(r)
      brd.empty(r,q)

      for c in (q+1..brd.size - 1)
        if brd.valid?(r, c)
          brd.queen(r,c)

          return true if r == brd.size - 1
          return true if fill_row_down(r + 1, brd)
          brd.empty(r,c)
        end
      end

      return false if r == 0
      return fill_row_up(r - 1, brd)
    end

    def find_all
      brd = find_first
      i = 0
      begin
        yield brd.clone
        i += 1
      end while(fill_row_up(Q8::MAX_INDEX, brd))
      i
    end

  end
end

# Q8::Solver.new.find_first

# Q8::Solver.new.find_each do |solution|
# end

# brd = Board.new
# brd.to_s



def debug_board(board)
  puts "==== BOARD ==="
  Q8::BOARD_SIZE.times do |r|
    puts board[r].join(' ')
  end
end
