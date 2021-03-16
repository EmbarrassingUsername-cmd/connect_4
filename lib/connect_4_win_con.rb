# Methods used to genrate win condition arrays
def make_diagonal_descending
  [[0, 3], [0, 4], [0, 5], [1, 5], [2, 5], [3, 5]].map do |i|
    output = []
    until i[0] == 7 || i[1] == -1
      output << i
      i = [i, [1, -1]].transpose.map(&:sum)
    end
    output
  end
end

def make_diagonal_ascending
  [[3, 0], [2, 0], [1, 0], [0, 0], [0, 1], [0, 2]].map do |i|
    output = []
    until i[0] == 7 || i[1] == 6
      output << i
      i = i.map { |num| num + 1 }
    end
    output
  end
end

p HORIZONTAL_LINES = 7.times.map { |i| [[*0..6], [i] * 7].transpose }
p VERTICAL_LINES = [*0..6].freeze
p DIAGONAL_ASCENDING = make_diagonal_ascending
p DIAGONAL_DESCENDING = make_diagonal_descending
