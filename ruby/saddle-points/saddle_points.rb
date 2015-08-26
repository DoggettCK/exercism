require 'set'

# Matrix class
class Matrix
  attr_reader :rows

  def initialize(s)
    @matrix = s.split("\n").map { |rs| rs.split(' ').map(&:to_i) }
    @rc = @matrix.length
    @cc = @matrix.first.length
    @col_mins = columns.map(&:min)
    @row_maxes = @matrix.map(&:max)
  end

  def rows
    @matrix
  end

  def columns
    first, *rest = @matrix
    first.zip(*rest)
  end

  def saddle_points
    Set.new((0...@rc).to_a.product((0...@cc).to_a).select do |i, j|
      @col_mins[j] == @matrix[i][j] && @row_maxes[i] == @matrix[i][j]
    end).to_a
  end
end
