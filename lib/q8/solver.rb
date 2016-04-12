module Q8
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