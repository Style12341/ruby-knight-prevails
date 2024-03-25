class KnightPuzzle
  def initialize
    @transformations = [[1, 2], [-1, 2], [2, 1], [2, 1], [1, - 2], [- 1, - 2], [- 2, 1], [- 2, - 1]]
    @visited_squares = Array.new(8) { Array.new(8, false) }
    @best_ans = Hash.new(nil)
  end

  def knight_moves(start, last)
    ans = knight_prevails(start, last)
    puts "You made it in #{ans.length - 1} moves! Here's your path:"
    ans.each { |move| p move }
  end

  def knight_prevails(start, last)
    return [last] if start == last
    return ans?(start) if ans?(start)
    return [] if visited?(start)

    visit(start)
    ans = Array.new(50)
    get_moves(start).each do |pair|
      curr_ans = knight_prevails(pair, last)
      ans = [start] + curr_ans if curr_ans.length + 1 < ans.length && curr_ans[-1] == last
    end
    set_best_ans(start, ans)
    ans
  end

  private

  def set_best_ans(pos, arr)
    @best_ans[pos] = arr
  end

  def visit(pos)
    @visited_squares[pos[0]][pos[1]] = true
  end

  def ans?(pos)
    @best_ans[pos]
  end

  def visited?(pos)
    @visited_squares[pos[0]][pos[1]]
  end

  def get_moves(pos)
    ans = []
    @transformations.each do |trans|
      ans << sum_pos(pos, trans) if in_bounds?(sum_pos(pos, trans))
    end
    ans
  end

  def sum_pos(pos1, pos2)
    [pos1[0] + pos2[0], pos1[1] + pos2[1]]
  end

  def in_bounds?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end
end

kp = KnightPuzzle.new
kp.knight_moves([3, 3], [4, 3])
