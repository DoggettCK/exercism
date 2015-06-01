# Binary to decimal conversion
class Binary
  VALID_CHARS = %w(0 1)

  def initialize(s)
    @str = s
  end

  def to_decimal
    decimal = 0

    @str.reverse.chars.each_with_index do |x, i|
      return 0 unless VALID_CHARS.include? x

      decimal += VALID_CHARS.index(x) * 2**i
    end

    decimal
  end
end
