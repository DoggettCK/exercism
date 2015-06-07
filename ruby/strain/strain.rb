# Array strainer
class Array
  def keep
    return to_enum(:each) unless block_given?

    inject([]) do |acc, x|
      if yield x
        acc << x
      else
        acc
      end
    end
  end

  def discard
    return to_enum(:each) unless block_given?

    inject([]) do |acc, x|
      if yield x
        acc
      else
        acc << x
      end
    end
  end
end
