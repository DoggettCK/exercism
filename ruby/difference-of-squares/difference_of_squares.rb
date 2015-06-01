# Calculates square of sums, sum of squares, and difference between them
class Squares
  def initialize(n)
    @num = n
  end

  def square_of_sums
    (@num * (@num + 1) / 2)**2
  end

  def sum_of_squares
    @num * (@num + 1) * (2 * @num + 1) / 6
  end

  def difference
    square_of_sums - sum_of_squares
  end
end
