defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    max = :math.sqrt(limit)
          |> Float.ceil
          |> round

    set = MapSet.new(2..limit)

    primes(2, max, limit, set) |> MapSet.to_list |> Enum.sort
  end

  defp primes(start, max, limit, set) when start > max, do: set
  defp primes(start, max, limit, set) do
    to_remove = start..limit
                |> Enum.take_every(start)
                |> Enum.drop(1)
                |> MapSet.new

    primes(start + 1, max, limit, MapSet.difference(set, to_remove))
  end
end
