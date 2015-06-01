# Convert modern to Roman numerals
class Fixnum
  ROMAN_NUMERALS = {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I'
  }

  def to_roman
    k = ROMAN_NUMERALS.keys.find { |x| x <= self }

    if k.nil?
      ''
    else
      ROMAN_NUMERALS[k] + (self - k).to_roman
    end
  end
end
