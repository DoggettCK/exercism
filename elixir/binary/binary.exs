defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    to_decimal(string, 0)
  end

  defp to_decimal("", result), do: result
  defp to_decimal(<< "1", rest::binary >>, result), do: to_decimal(rest, 2 * result + 1)
  defp to_decimal(<< "0", rest::binary >>, result), do: to_decimal(rest, 2 * result)
  defp to_decimal(_, _), do: 0
end
