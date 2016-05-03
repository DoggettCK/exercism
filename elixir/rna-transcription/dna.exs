defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &transcribe/1)
  end

  for {dna, rna} <- %{?G => ?C, ?C => ?G, ?T => ?A, ?A => ?U} do
    defp transcribe(unquote(dna)), do: unquote(rna)
  end

  defp transcribe(_), do: raise ArgumentError
end
