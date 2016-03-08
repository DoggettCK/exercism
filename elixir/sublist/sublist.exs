defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      equal?(a, b) -> :equal
      contains?(b, a) -> :sublist
      contains?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp equal?([], []), do: true
  defp equal?(_, []), do: false
  defp equal?([], _), do: false
  defp equal?([h | t1], [h | t2]), do: equal?(t1, t2)
  defp equal?([_ | _], [_ | _]), do: false

  defp contains?(_, []), do: true
  defp contains?([], _), do: false
  defp contains?([h | t1] = one, [h | _] = two) do
    cond do
      one
      |> Enum.take(Enum.count(two))
      |> equal?(two) -> true
      true -> contains?(t1, two)
    end
  end
  defp contains?([_ | t1], l2), do: contains?(t1, l2)
end
