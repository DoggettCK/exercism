defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numerals(number, "")
  end

  @conversions [M: 1000, CM: 900, D: 500, CD: 400, C: 100, XC: 90, L: 50, XL: 40, X: 10, IX: 9, V: 5, IV: 4, I: 1]

  for {roman, arabic} <- @conversions do
    defp numerals(number, result) when number >= unquote(arabic), do: numerals(number - unquote(arabic), result <> unquote(roman |> to_string))
  end

  defp numerals(_, result), do: result
end
