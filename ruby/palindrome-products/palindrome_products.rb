require 'set'

# Palindrome products
class Palindromes
  def initialize(options = {})
    @min = options[:min_factor] || 0
    @max = options[:max_factor] || 0
    @palindromes = {}
  end

  def generate
    (@min..@max).to_a.product((@min..@max).to_a).each do |x, y|
      value = x * y

      next unless palindrome?(value) || value == 0

      palindrome = @palindromes.fetch(value, Palindrome.new(value))

      palindrome.factor_set.add(x <= y ? [x, y] : [y, x])

      @palindromes[value] = palindrome
    end
  end

  def palindrome?(n)
    n.to_s.reverse == n.to_s
  end

  def largest
    @palindromes[@palindromes.keys.max]
  end

  def smallest
    @palindromes[@palindromes.keys.min]
  end
end

# Palindrome with factors
class Palindrome
  include Comparable

  attr_accessor :value, :factor_set

  def initialize(value)
    @value = value
    @factor_set = Set.new
  end

  def factors
    @factor_set.to_a
  end
end
