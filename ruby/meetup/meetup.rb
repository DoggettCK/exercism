require 'date'

# Meetup calculator
class Meetup
  DAYS = \
    %w(sunday monday tuesday wednesday thursday friday saturday) \
    .map { |d| [d.to_sym, "#{d}?"] }.to_h

  SCHEDULES = {
    first: 0,
    second: 1,
    third: 2,
    fourth: 3,
    last: -1
  }

  def initialize(month, year)
    @start = Date.new(year, month, 1)
    @end = (@start >> 1) - 1
    @dates = (@start..@end)
  end

  def day(weekday, schedule)
    method = DAYS[weekday]
    index = SCHEDULES[schedule]

    if schedule == :teenth
      @dates.find { |d| d.day.between?(13, 19) && d.method(method).call }
    else
      @dates.select { |d| d.method(method).call }[index]
    end
  end
end
