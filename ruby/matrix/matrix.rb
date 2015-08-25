# Matrix class
class Matrix
  attr_reader :rows

  def initialize(s)
    @matrix = s.split("\n").map { |rs| rs.split(' ').map(&:to_i) }
  end

  def rows
    @matrix
  end

  def columns
    first, *rest = @matrix
    first.zip(*rest)
  end
end
