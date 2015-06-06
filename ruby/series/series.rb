# Find series of sequential numbers in string
class Series
  def initialize(str)
    @chars = str.chars.map(&:to_i)
  end

  def slices(n)
    fail ArgumentError if n > @chars.length

    (0..(@chars.length - n)).map { |x| @chars[x...(x + n)] }
  end
end
