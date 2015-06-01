# Phone number validator
class PhoneNumber
  BAD_NUMBER = '0' * 10

  def initialize(phone)
    @phone = phone
  end

  def number
    return BAD_NUMBER if @phone =~ /[[:alpha:]]/

    clean_phone = @phone.gsub(/\D/, '')

    case clean_phone
    when /^\d{10}$/
      clean_phone
    when /^1\d{10}$/
      clean_phone[1..-1]
    else
      BAD_NUMBER
    end
  end

  def area_code
    number[0, 3]
  end

  def to_s
    clean = number
    "(#{clean[0, 3]}) #{clean[3, 3]}-#{clean[6, 4]}"
  end
end
