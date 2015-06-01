# Robot random namer
class Robot
  attr_reader :name

  def initialize
    reset
  end

  def new_name
    (sample_range('A'..'Z', 2) + sample_range(0..9, 3)).join
  end

  def reset
    @name = new_name
  end

  private

  def sample_range(range, count)
    ([*range] * count).sample(count)
  end
end
