# Custom reduce method
class Array
  def accumulate
    return to_enum(:each) unless block_given?

    result = []

    each { |x| result << (yield x) }

    result
  end
end
