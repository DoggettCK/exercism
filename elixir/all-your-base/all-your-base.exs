defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_digits, base_a, base_b) when base_a <= 1 or base_b <= 1, do: nil
  def convert(digits, base_a, base_b) do
    digits 
    |> from_base(base_a, 0)
    |> to_base(base_b, [])
  end

  defp from_base([], _base, result), do: result
  defp from_base([head|_tail], _base, _result) when head < 0, do: nil
  defp from_base([head|_tail], base, _result) when head >= base, do: nil
  defp from_base([head|tail], base, result), do: from_base(tail, base, result * base + head)

  defp to_base(nil, _, _), do: nil
  defp to_base(0, _base, []), do: [0]
  defp to_base(0, _base, result), do: result
  defp to_base(int, base, result), do: to_base(div(int, base), base, [rem(int, base) | result])
end
