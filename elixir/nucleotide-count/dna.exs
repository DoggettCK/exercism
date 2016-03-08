defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  for nucleotide <- @nucleotides do
    @spec count([char], char) :: non_neg_integer
    def count(strand, unquote(nucleotide)) do
      strand |> histogram |> Dict.get(unquote(nucleotide), 0)
    end
  end

  def count(strand, _), do: raise ArgumentError

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: Map
  def histogram(strand) do
    counts = @nucleotides |> Enum.zip([0] |> Stream.cycle) |> Enum.into(%{})

    strand
    |> to_char_list
    |> Enum.reduce(counts, &update_nucleotide_count/2)
  end

  for char <- @nucleotides do
    defp update_nucleotide_count(unquote(char), acc) do
      acc |> Map.update(unquote(char), 1, &(&1 + 1))
    end
  end

  defp update_nucleotide_count(char, acc), do: raise ArgumentError
end
