# House poem
class House
  VERSES = [
    { subject: 'house', verb: 'Jack built' },
    { subject: 'malt', verb: 'lay in' },
    { subject: 'rat', verb: 'ate' },
    { subject: 'cat', verb: 'killed' },
    { subject: 'dog', verb: 'worried' },
    { subject: 'cow with the crumpled horn', verb: 'tossed' },
    { subject: 'maiden all forlorn', verb: 'milked' },
    { subject: 'man all tattered and torn', verb: 'kissed' },
    { subject: 'priest all shaven and shorn', verb: 'married' },
    { subject: 'rooster that crowed in the morn', verb: 'woke' },
    { subject: 'farmer sowing his corn', verb: 'kept' },
    { subject: 'horse and the hound and the horn', verb: 'belonged to' }
  ].each_with_index.map do |verse, i|
    sep = i == 0 ? ' ' : "\n"
    "the #{verse[:subject]}#{sep}that #{verse[:verb]}"
  end

  def self.verse(num)
    "This is #{VERSES[0..num].reverse.join(' ')}.\n"
  end

  def self.recite
    (0...VERSES.length).map { |i| verse(i) }.join("\n")
  end
end
