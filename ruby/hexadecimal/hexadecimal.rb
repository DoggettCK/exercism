# Hexadecimal conversion
class Hexadecimal
  def initialize(hex)
    @hex = hex.upcase
  end

  def to_decimal
    if @hex !~ /^[0-9A-F]+$/
      0
    else
      l = @hex.length - 1

      hl = [*('0'..'9'), *('A'..'F')]

      @hex.chars.map.with_index { |c, i| hl.index(c) * 16**(l - i) }.inject(&:+)
    end
  end
end
