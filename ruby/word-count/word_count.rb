# Counts the occurrences of each word in a phrase
class Phrase
  def initialize(phrase)
    @counts = Hash.new(0)

    phrase.split(/[^\w']/).reject(&:empty?).each do |word|
      @counts[word.downcase] += 1
    end
  end

  def word_count
    @counts
  end
end
