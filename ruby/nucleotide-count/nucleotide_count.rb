# Nucleotide counter
class Nucleotide
  def initialize(dna)
    @dna = dna
  end

  def self.from_dna(dna)
    fail ArgumentError unless dna =~ /^[ACGT]*$/

    Nucleotide.new(dna)
  end

  def count(symbol)
    histogram.fetch(symbol, 0)
  end

  def histogram
    gram = %w(A C G T).zip([0] * 4).to_h

    @dna.scan(/\w/).each_with_object(gram) { |c, h| h[c] += 1 }
  end
end
