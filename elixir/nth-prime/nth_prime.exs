defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count >= 1 do
    prime_stream |> Enum.take(count) |> List.last
  end
  def nth(_), do: raise ArgumentError

  @doc """
  Generate an infinite sequence of prime numbers.

  Thanks to http://stackoverflow.com/a/2212923/64203 for Python version
  """
  def prime_stream do
    # Maps composites to primes witnessing their compositeness.
    # This is memory efficient, as the sieve is not "run forward"
    # indefinitely, but only as long as required by the current
    # number being tested
    Stream.resource(fn -> {2, %{}, false} end,
    fn
      {q, composites, false} ->
        # q is a new prime
        # yield it and mark its first multiple that isn't
        # already marked in previous iterations
        next = q + 1
        composites = composites |> Map.put(q*q, [q])

        {[q], {next, composites, Map.has_key?(composites, next)}}
      {q, composites, true} ->
        # q is composite. composites[q] is the list of primes that
        # divide it. Since we've reached q, we no longer need it
        # in the map, but we'll mark the next multiples of its
        # witnesses to prepare for larger numbers
        next = q + 1

        composites = composites
                      |> Map.get(q)
                      |> Enum.reduce(composites, fn (p, acc) -> acc |> Map.update(p + q, [p], &([p | &1])) end)
                      |> Map.delete(q)
        {[], {next, composites, Map.has_key?(composites, next)}}
    end,
    fn _ -> nil end)
  end
end
