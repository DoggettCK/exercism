defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  4
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    hamming_distance(strand1, strand2, 0)
  end

  defp hamming_distance([], [], count), do: count
  defp hamming_distance(_, [], _), do: nil
  defp hamming_distance([], _, _), do: nil
  defp hamming_distance([h | t1], [h | t2], count), do: hamming_distance(t1, t2, count)
  defp hamming_distance([h1 | t1], [h2 | t2], count), do: hamming_distance(t1, t2, count + 1)
end
