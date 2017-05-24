defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide), do: strand |> Enum.count(& nucleotide == &1)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    [0]
    |> Stream.cycle
    |> Enum.zip(@nucleotides)
    |> Enum.into(%{}, fn {v, k} -> {k, v} end)
    |> do_histogram(strand)
  end

  defp do_histogram(results, []), do: results
  for nucleotide <- @nucleotides do
    defp do_histogram(results, [unquote(nucleotide) | rest]) do
      results
      |> Map.update(unquote(nucleotide), 1, &(&1 + 1))
      |> do_histogram(rest)
    end
  end
end
