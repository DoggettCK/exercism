defmodule Flattener do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> Flattener.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> Flattener.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list), do: flatten(list, 0, [])

  defp flatten([], 0, results), do: Enum.reverse(results)
  defp flatten([], _, results), do: results
  defp flatten([nil | rest], level, results), do: flatten(rest, level, results)
  defp flatten([[] | rest], level, results), do: flatten(rest, level, results)
  defp flatten([h | rest], level, results) when is_list(h), do: flatten(rest, level, flatten(h, level + 1, results))
  defp flatten([h | rest], level, results), do: flatten(rest, level, [h | results])
end
