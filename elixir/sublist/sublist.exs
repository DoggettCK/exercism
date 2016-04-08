defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b), do: check_equal(a, b, equal?(a, b))

  defp check_equal(_, _, true), do: :equal
  defp check_equal(a, b, _), do: check_sublist(a, b, contains?(b, a))

  defp check_sublist(_, _, true), do: :sublist
  defp check_sublist(a, b, _), do: check_superlist(a, b, contains?(a, b))

  defp check_superlist(_, _, true), do: :superlist
  defp check_superlist(_, _, _), do: :unequal

  defp equal?([], []), do: true
  defp equal?([h | t1], [h | t2]), do: equal?(t1, t2)
  defp equal?(_, _), do: false

  defp contains?(_, []), do: true
  defp contains?([], _), do: false
  defp contains?([h | t1] = one, [h | _] = two) do
    Enum.take(one, Enum.count(two)) |> equal?(two) or contains?(t1, two)
  end
  defp contains?([_ | t1], l2), do: contains?(t1, l2)
end
