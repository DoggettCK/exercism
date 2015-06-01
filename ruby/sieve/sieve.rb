require 'set'

# Sieve of Eratosthenes
class Sieve
  def initialize(max)
    @max = max
  end

  def primes
    prime_numbers = Set.new(2..@max)

    2.upto(Math.sqrt(@max).ceil) do |x|
      ((x + x)..@max).step(x) do |np|
        prime_numbers.delete(np)
      end
    end

    prime_numbers.to_a
  end
end
