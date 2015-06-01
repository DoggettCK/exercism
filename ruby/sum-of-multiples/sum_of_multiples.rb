# Sums multiples of 3, 5, or arbitrary numbers
class SumOfMultiples
  def initialize(*multiples)
    @multiples = multiples.any? ? multiples : [3, 5]
  end

  def self.to(num)
    SumOfMultiples.new.to(num)
  end

  def to(num)
    (1...num).select { |i| @multiples.any? { |x| i % x == 0 } }.inject(0, :+)
  end
end
