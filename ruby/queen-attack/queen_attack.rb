# Queen attack checker
class Queens
  attr_reader :white, :black

  def initialize(options = {})
    @white = options[:white] || [0, 3]
    @black = options[:black] || [7, 3]

    fail ArgumentError if @white == @black
  end

  def to_s
    board = '_' * 64

    w_x, w_y = @white
    b_x, b_y = @black

    board[w_x * 8 + w_y] = 'W'
    board[b_x * 8 + b_y] = 'B'

    board.chars.each_slice(8).map { |a| a.join(' ') }.join("\n")
  end

  def attack?
    w_x, w_y = @white
    b_x, b_y = @black

    w_x == b_x || w_y == b_y || (w_x - b_x).abs == (w_y - b_y).abs
  end
end
