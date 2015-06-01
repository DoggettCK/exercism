# Array strainer
class Array
  def keep
    return [] if empty?

    return self unless block_given?

    result = []

    each { |x| result << x if yield x }

    result
  end

  def discard
    return [] if empty?

    return self unless block_given?

    result = []

    each { |x| result << x unless yield x }

    result
  end
end
