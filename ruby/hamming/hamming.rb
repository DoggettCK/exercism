require 'set'

# Calculate hamming distance between strings
class Hamming
  def self.compute(source, dest)
    fail ArgumentError if source.length != dest.length

    source.chars.zip(dest.chars).inject(0) do |a, e|
      a + (Set.new(e).length - 1)
    end
  end
end
