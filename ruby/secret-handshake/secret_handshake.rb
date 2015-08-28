# Secret Handshake
class SecretHandshake
  CODES = {
    1 => 'wink',
    2 => 'double blink',
    4 => 'close your eyes',
    8 => 'jump',
    16 => 'reverse'
  }

  def initialize(value)
    if value.is_a? Integer
      @value = value & 31
    elsif (value.is_a? String) && value =~ /^[01]+$/
      @value = value.to_i(2) & 31
    else
      @value = 0
    end
  end

  def commands
    commands = []

    CODES.each { |k, v| commands << v if (@value & k) == k }

    if commands[-1] == 'reverse'
      commands.pop
      commands.reverse!
    end

    commands
  end
end
