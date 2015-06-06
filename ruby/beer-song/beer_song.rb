# Beer song
class BeerSong
  def initialize

  end

  def verse(n)
    case n
    when 0
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    when 1
      bottles = pluralize(1, 'bottle')
      "#{bottles} of beer on the wall, #{bottles} of beer.\n" \
        "Take it down and pass it around, no more bottles of beer on the wall.\n" 
    else 
      current = pluralize(n, 'bottle')
      nxt = pluralize(n-1, 'bottle')
      "#{current} of beer on the wall, #{current} of beer.\n" \
        "Take one down and pass it around, #{nxt} of beer on the wall.\n"
    end
  end

  def verses(first, last)
    first.downto(last).map { |x| self.verse(x) }.join("\n")
  end

  def sing
    verses(99, 0)
  end

  private

  def pluralize(n, singular, plural=nil)
    if 1 == n
      "1 #{singular}"
    elsif plural
      "#{n} #{plural}"
    else
      "#{n} #{singular}s"
    end
  end
end
