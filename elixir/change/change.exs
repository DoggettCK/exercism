defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    make_change(amount, values |> Enum.sort |> Enum.reverse, values |> Enum.into(%{}, fn k -> {k, 0} end))
  end

  defp make_change(remaining, [], _) when remaining > 0, do: :error
  defp make_change(0, [], results), do: { :ok, results }
  defp make_change(remaining, [h | t], results) when remaining >= h, do: make_change(remaining - h, [h | t], results |> Map.update(h, 1, &(&1 + 1)))
  defp make_change(remaining, [_ | t], results), do: make_change(remaining, t, results)
end
