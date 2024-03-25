$visited_squares = Array.new(8) { Array.new(8, false) }
$best_ans = Hash.new(nil)
# Both pairs
def in_bounds?(row, col)
  row.between?(0, 7) && col.between?(0, 7)
end

def get_possible_moves(pos)
  [[pos[0] + 1, pos[1] + 2], [pos[0] - 1, pos[1] + 2], [pos[0] + 2, pos[1] + 1], [pos[0] + 2, pos[1] - 1], [pos[0] + 1, pos[1] - 2],
   [pos[0] - 1, pos[1] - 2], [pos[0] - 2, pos[1] + 1], [pos[0] - 2, pos[1] - 1]]
end

def knight_prevails(start, last)
  start_row = start[0]
  start_col = start[1]
  return [] unless in_bounds?(start_row, start_col)
  return [last] if start == last
  return $best_ans[start] if $best_ans[start]
  return [] if $visited_squares[start_row][start_col]

  $visited_squares[start_row][start_col] = true
  ans = Array.new(200)
  get_possible_moves(start).each do |pair|
    aux = knight_prevails(pair, last)
    p 'help' if start == [2, 4] and pair == [4, 3]
    ans = [start] + aux if aux.length + 1 < ans.length && aux[-1] == last
  end
  $best_ans[start] = ans
  ans
end

p knight_prevails([0, 0], [7, 7])
