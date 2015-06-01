# Calculates whether a year is a leap year or not
class Year
  def self.leap?(year)
    (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
  end
end
