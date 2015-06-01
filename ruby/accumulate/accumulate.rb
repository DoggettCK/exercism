# Custom reduce method
class Array
  def accumulate(&block)
    result = []

    each { |x| result.push block.call(x) }

    result
  end
end
