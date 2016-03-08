defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """
  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    days_and_dates(year, month)
    |> Enum.filter(fn {k, _} -> k == weekday end)
    |> get_day_of_month(schedule)
    |> Tuple.insert_at(0, month)
    |> Tuple.insert_at(0, year)
  end

  defp days_and_dates(year, month) do
    offset = :calendar.day_of_the_week(year, month, 1) - 1

    weekdays = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  
    Stream.cycle(weekdays)
    |> Enum.take(offset + :calendar.last_day_of_the_month(year, month))
    |> Enum.drop(offset)
    |> Enum.with_index(1)
  end

  defp get_day_of_month(case_of_the_mondays, :last) do
    case_of_the_mondays
    |> List.last
    |> Tuple.delete_at(0)
  end

  defp get_day_of_month(case_of_the_mondays, :teenth) do
    case_of_the_mondays
    |> Enum.find(fn({_, v}) -> v >= 13 and v <= 19 end)
    |> Tuple.delete_at(0)
  end
  
  for {sch, day} <- [first: 7, second: 14, third: 21, fourth: 28] do
    defp get_day_of_month(case_of_the_mondays, unquote(sch)) do
      case_of_the_mondays
      |> Enum.find(fn({_, v}) -> v <= unquote(day) and v >= unquote(day)-6 end)
      |> Tuple.delete_at(0)
    end
  end
end
