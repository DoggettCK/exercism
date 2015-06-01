# Prime number factorization
class PrimeFactors
  def self.for(n)
    return [] if n < 2

    factor = (2..Math.sqrt(n).ceil).find { |x| n % x == 0 }

    if factor.nil?
      [n]
    else
      [factor] + PrimeFactors.for(n / factor)
    end
  end
end
