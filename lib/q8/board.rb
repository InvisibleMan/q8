module Q8
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

      str.gsub(' ', '').split(',').each do |pair|
        r = Q8::BOARD_SIZE - pair[1].to_i
        c = letters.index(pair[0])

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
end