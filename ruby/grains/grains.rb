# Count grains of wheat on a chessboard
class Grains
  @board = (0...64).map { |x| 2**x }
  @total = @board.reduce :+

  attr_reader :total

  def self.square(n)
    @board[n - 1]
  end
end
