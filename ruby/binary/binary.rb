# Binary to decimal conversion
class Binary
  def initialize(s)
    @str = s
  end

  def to_decimal
    if @str !~ /^[01]+$/
      0
    else
      len = @str.length - 1
      @str.chars.each_with_index.inject(0) do |acc, (x, i)|
        acc + x.to_i * 2**(len - i)
      end
    end
  end
end
