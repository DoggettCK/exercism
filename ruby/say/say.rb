# Say numbers
class Say
  MODS = {
    1_000_000_000 => 'billion',
    1_000_000 => 'million',
    1_000 => 'thousand'
  }

  LOOKUP = {
    1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four', 5 => 'five',
    6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine', 10 => 'ten',
    11 => 'eleven', 12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen',
    15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen',
    19 => 'nineteen', 20 => 'twenty', 30 => 'thirty', 40 => 'forty',
    50 => 'fifty', 60 => 'sixty', 70 => 'seventy', 80 => 'eighty',
    90 => 'ninety'
  }

  def initialize(number)
    @number = number
  end

  def in_english
    fail ArgumentError unless @number.between?(0, 999_999_999_999)

    return 'zero' if @number.zero?

    result = []
    number = @number

    MODS.each do |mod, word|
      count, number = number.divmod(mod)

      result << [under_thousand(count), word].join(' ') unless count.zero?
    end

    result << under_thousand(number) if number > 0

    result.join(' ')
  end

  def under_hundred(number)
    return LOOKUP[number] if number < 20

    tens, ones = number.divmod(10)

    [tens * 10, ones].map { |x| LOOKUP[x] }.join('-').gsub(/^-|-$/, '')
  end

  def under_thousand(number)
    hundreds, tens = number.divmod(100)

    result = []

    result << "#{LOOKUP[hundreds]} hundred" unless hundreds.zero?

    result << under_hundred(tens) unless tens.zero?

    result.join(' ')
  end
end
