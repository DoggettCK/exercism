# Trinary converter
class Trinary
  def initialize(trinary)
    @trinary = trinary
    @len = @trinary.length - 1
  end

  def to_decimal
    index = -1

    @trinary.chars.inject(0) do |acc, x|
      index += 1
      acc + x.to_i * 3**(@len - index)
    end
  end
end
