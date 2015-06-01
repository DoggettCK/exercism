require 'set'

# Nth prime generator using Sieve of Eratosthenes
class Prime
  def nth(n)
    fail ArgumentError unless n > 0

    if n < 6
      [2, 3, 5, 7, 11][n - 1]
    else
      sieve(n).take(n)[-1]
    end
  end

  def sieve(n)
    # According to http://math.stackexchange.com/a/1259
    # nth prime will be < n(ln(n)) + n(ln(ln(n))) for n >= 6
    upper_bound = ((n * Math.log(n)) + (n * Math.log(Math.log(n)))).ceil

    primes = Set.new(2..upper_bound)

    2.upto(Math.sqrt(upper_bound).ceil) do |x|
      ((x + x)..upper_bound).step(x) do |np|
        primes.delete(np)
      end
    end

    primes
  end
end
