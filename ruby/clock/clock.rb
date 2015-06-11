# Clock addition
class Clock
  attr_reader :hour, :minute

  def initialize(hour, minute = 0)
    @hour = hour
    @minute = minute
  end

  def self.at(hour, minute = 0)
    Clock.new(hour, minute)
  end

  def +(other)
    h, @minute = (@minute + other).divmod(60)
    @hour = (@hour + h) % 24
    self
  end

  def -(other)
    h, @minute = (@minute - other).divmod(60)
    @hour = (@hour + h) % 24
    self
  end

  def ==(other)
    @hour == other.hour && @minute == other.minute
  end

  def to_s
    format('%02d:%02d', @hour, @minute)
  end
end
