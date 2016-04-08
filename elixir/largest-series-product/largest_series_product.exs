defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product("", _), do: raise ArgumentError
  def largest_product(_, size) when size < 0, do: raise ArgumentError
  def largest_product(number_string, size), do: largest_product(number_string, size, String.length(number_string))
  defp largest_product(number_string, size, string_size) when size > string_size, do: raise ArgumentError
  defp largest_product(number_string, size, string_size) do
    number_string
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk(size, 1)
    |> Enum.map(&(Enum.reduce(&1, 1, fn(x, acc) -> x * acc end)))
    |> Enum.max
  end
end
