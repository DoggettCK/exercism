defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @alphabet ?a..?z |> Enum.to_list |> to_string

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r{[^a-z]}, "") 
    |> String.graphemes
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.map(&(&1 |> hd))
    |> Enum.join
    |> Kernel.==(@alphabet)
  end
end
