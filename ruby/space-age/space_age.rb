# Calculates age on a given planet
class SpaceAge
  EARTH_YEARS = {
    'mercury' => 0.2408467,
    'venus' => 0.61519726,
    'mars' => 1.8808158,
    'jupiter' => 11.862615,
    'saturn' => 29.447498,
    'uranus' => 84.016846,
    'neptune' => 164.79132
  }

  def initialize(n)
    @n = n.to_f
  end

  def seconds
    @n
  end

  def respond_to?(method_sym, include_private = false)
    if method_sym.to_s =~ /^on_(.*)$/
      true
    else
      super
    end
  end

  def method_missing(method_sym, *arguments, &block)
    if method_sym.to_s =~ /^on_(.*)$/
      planet = method_sym[3..-1]

      on_earth / EARTH_YEARS[planet]
    else
      super
    end
  end

  # Earth => orbital period 365.25 Earth days, or 31557600 seconds
  def on_earth
    @n / 31_557_600
  end
end
