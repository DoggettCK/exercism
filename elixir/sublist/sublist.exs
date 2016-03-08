defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a |> equal?(b) -> :equal
      b |> contains?(a) -> :sublist
      a |> contains?(b) -> :superlist
      true -> :unequal
    end
  end

  defp equal?([], []), do: true
  defp equal?(_, []), do: false
  defp equal?([], _), do: false
  defp equal?([h | t1], [h | t2]), do: t1 |> equal?(t2)
  defp equal?([_ | _], [_ | _]), do: false

  defp contains?(_, []), do: true
  defp contains?([], _), do: false
  defp contains?([h | t1] = one, [h | _] = two) do
    cond do
      one
      |> Enum.take(Enum.count(two))
      |> equal?(two) -> true
      true -> t1 |> contains?(two)
    end
  end
  defp contains?([_ | t1], l2), do: t1 |> contains?(l2)
end
