defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a string representation of a clock:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    %Clock{} |> add(hour * 60) |> add(minute)
  end

  @doc """
  Adds two clock times:

      iex> Clock.add(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    hours_from_minutes = div(add_minute, 60)
    remaining_minutes = rem(add_minute, 60)

    hours = cond do
      minute + remaining_minutes < 0 -> hours_from_minutes - 1
      minute + remaining_minutes >= 60 -> hours_from_minutes + 1
      true -> hours_from_minutes
    end

    %Clock{
      hour: (hour + hours) |> scale_to(24), 
      minute: (minute + remaining_minutes) |> scale_to(60) 
    }
  end

  defp scale_to(number, max) when is_integer(number) and is_integer(max) and max > 0 do
    number
    |> rem(max)
    |> Kernel.+(max)
    |> rem(max)
  end

  defimpl String.Chars, for: Clock do
    def to_string(%Clock{hour: hour, minute: minute}) do
      [hour, minute]
      |> Enum.map(&(&1 |> Integer.to_string |> String.rjust(2, ?0)))
      |> Enum.join(":")
    end
  end
end
