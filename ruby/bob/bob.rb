# Surly teenager simulator
class Bob
  def hey(phrase)
    return 'Fine. Be that way!' if phrase.nil? || phrase.gsub(/\s/, '').empty?

    return 'Whoa, chill out!' if phrase.gsub(/[\W0-9]/, '') =~ /\A[A-Z]+\Z/

    return 'Sure.' if phrase =~ /\?\Z/

    'Whatever.'
  end
end
