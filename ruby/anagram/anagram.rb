# Anagram checker
class Anagram
  def initialize(word)
    @word = word.downcase
    @sorted_word = @word.chars.sort.join
  end

  def match(candidates)
    candidates.select do |w|
      dc = w.downcase
      dc.chars.sort.join == @sorted_word && dc != @word
    end
  end
end
