# Atbash cipher
class Atbash
  FROM = ('a'..'z').to_a.join
  TO = FROM.reverse

  def self.encode(s)
    s.downcase.gsub(/\W/, '').tr(FROM, TO).scan(/.{1,5}/).join(' ')
  end
end
