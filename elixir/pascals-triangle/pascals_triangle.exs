defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: next_row(num, [])

  defp next_row(0, results), do: results |> Enum.reverse
  defp next_row(num, []), do: next_row(num - 1, [[1]])
  defp next_row(num, [prev | _] = results) do
    curr = [1 | prev |> Enum.chunk(2, 1, [0]) |> Enum.map(&Enum.sum/1)]

    next_row(num - 1, [curr | results])
  end
end
