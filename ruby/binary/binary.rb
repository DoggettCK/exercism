# Binary to decimal conversion
class Binary
  def initialize(s)
    @str = s
    @len = s.length - 1
  end

  def to_decimal
    return 0 unless @str =~ /^[01]+$/

    @str.chars.each_with_index.inject(0) do |acc, (x, i)|
      acc + x.to_i * 2**(@len - i)
    end
  end
end
