# Beer song
class BeerSong
  NONE_LEFT = \
    "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

  ONE_LEFT = \
    "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n"

  def initialize
  end

  def verse(n)
    if 0 == n
      NONE_LEFT
    elsif 1 == n
      ONE_LEFT
    else
      curr = pluralize(n, 'bottle')
      nv = pluralize(n - 1, 'bottle')
      "#{curr} of beer on the wall, #{curr} of beer.\n" \
        "Take one down and pass it around, #{nv} of beer on the wall.\n"
    end
  end

  def verses(first, last)
    # Would be better with .join("\n"), but tests specify 2 newlines after each
    first.downto(last).map { |x| verse(x) + "\n" }.join
  end

  def sing
    verses(99, 0)
  end

  private

  def pluralize(n, singular, plural = nil)
    if 1 == n
      "1 #{singular}"
    elsif plural
      "#{n} #{plural}"
    else
      "#{n} #{singular}s"
    end
  end
end
