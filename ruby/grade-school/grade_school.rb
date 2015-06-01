# Grade school simulator
class School
  def initialize
    @students = new_hash
  end

  def add(student, grade_num)
    @students[grade_num] << student
    @students[grade_num].sort!
  end

  def grade(grade_num)
    @students[grade_num].dup
  end

  def to_hash
    h = new_hash

    @students.keys.sort.each { |k| h[k] = @students[k].dup }

    h
  end

  private

  def new_hash
    Hash.new { |h, k| h[k] = [] }
  end
end
