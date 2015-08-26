# Triangle
class Triangle
  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c

    fail TriangleError if [a, b, c].any? { |x| x <= 0 }
    fail TriangleError if (@a + @b) <= @c
    fail TriangleError if (@b + @c) <= @a
    fail TriangleError if (@a + @c) <= @b
  end

  def kind
    return :equilateral if @a == @b && @b == @c
    return :isosceles if @a == @b || @b == @c || @a == @c
    :scalene
  end
end

# TriangleError
class TriangleError < ArgumentError
end
