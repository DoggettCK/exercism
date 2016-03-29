defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    0..(limit-1)
    |> Enum.filter(&(any_factor?(&1, factors)))
    |> Enum.sum
  end

  defp any_factor?(n, factors), do: Enum.any?(factors, &(rem(n, &1) == 0))
end
