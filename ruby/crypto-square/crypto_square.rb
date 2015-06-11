# Crypto square
class Crypto
  attr_reader :size

  def initialize(plaintext)
    @plaintext = plaintext
  end

  def normalize_plaintext
    @plaintext.gsub(/\W/, '').downcase
  end

  def size
    square_size(normalize_plaintext)
  end

  def plaintext_segments
    normalized = normalize_plaintext

    chunk_string(normalized, square_size(normalized))
  end

  def ciphertext
    ciphertext_segments.join
  end

  def normalize_ciphertext
    ciphertext_segments.join(' ')
  end

  def ciphertext_segments
    segments = plaintext_segments.map(&:chars)

    segments.shift.zip(*segments).map(&:join)
  end

  private

  def square_size(str)
    Math.sqrt(str.length).ceil
  end

  def chunk_string(str, chunk_size)
    str.scan(/.{1,#{chunk_size}}/)
  end
end
