defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    :math.pow(2, number - 1) |> round
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    powers_of_two |> Enum.take(64) |> Enum.sum
  end

  defp powers_of_two, do: Stream.resource(fn -> 1 end, fn i -> {[i], i * 2} end, fn _ -> nil end)
end
