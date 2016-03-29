defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    (for x <- min_factor..max_factor, y <- min_factor..max_factor, do: Enum.sort([x, y]))
    |> Enum.filter(fn [x, y] -> palindrome?(x * y) end)
    |> Enum.reduce(%{}, &update_map/2)
    |> Enum.into(%{}, &dedupe_list/1)
  end

  defp dedupe_list({k, v}), do: {k, v |> MapSet.new |> MapSet.to_list}
  defp update_map([x, y], map), do: Map.update(map, x * y, [[x, y]], &[[x, y] | &1])

  defp palindrome?(str) when is_binary(str), do: str == String.reverse(str)
  defp palindrome?(num) when is_number(num), do: palindrome?(to_string(num))
end
