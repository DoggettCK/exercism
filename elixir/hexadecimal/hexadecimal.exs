defmodule Hexadecimal do
  @doc """
  Accept a string representing a hexadecimal value and returns the
  corresponding decimal value.
  It returns the integer 0 if the hexadecimal is invalid.
  Otherwise returns an integer representing the decimal value.

  ## Examples

  iex> Hexadecimal.to_decimal("invalid")
  0

  iex> Hexadecimal.to_decimal("af")
  175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    # Could just try/rescue String.to_integer(hex, 16), but that's not the point of the exercise, I assume.
    hex
    |> String.downcase
    |> String.split("", trim: true)
    |> Enum.map(&hex_to_dec/1)
    |> Enum.reverse
    |> Enum.with_index
    |> reduce(0)
  end

  for {char, index} <- "0123456789abcdef" |> String.split("", trim: true) |> Enum.with_index do
    defp hex_to_dec(unquote(char)), do: unquote(index)
  end
  defp hex_to_dec(_), do: :error

  defp reduce([], acc), do: acc
  defp reduce([{:error, _} | _], _), do: 0
  defp reduce([{n, i} | t], acc), do: reduce(t, acc + n * round(:math.pow(16, i)))
end
