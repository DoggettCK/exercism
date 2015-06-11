# Acronym generator
class Acronym
  VERSION = 1

  def self.abbreviate(phrase)
    phrase.split(/\W+/).flat_map { |word| split_camelcase(word) }.join.upcase
  end

  def self.split_camelcase(word)
    if word =~ /^[[:upper:]]+$/
      word[0]
    else
      word.split(/(?=[A-Z])/).map { |w| w[0] }
    end
  end
end
