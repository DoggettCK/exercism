# Prime number factorization
class PrimeFactors
  def self.for(n, acc = [])
    return acc if n < 2

    factor = (2..Math.sqrt(n).ceil).find { |x| n % x == 0 }

    return acc << n if factor.nil?

    PrimeFactors.for(n / factor, acc << factor)
  end
end
