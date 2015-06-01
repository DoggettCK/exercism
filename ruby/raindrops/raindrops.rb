# Basically Fizzbuzz with different words
class Raindrops
  WORDS = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }

  def self.convert(n)
    prime_factors = WORDS.select { |k, _| n % k == 0 }

    prime_factors.empty? ? n.to_s : prime_factors.values.join
  end
end
