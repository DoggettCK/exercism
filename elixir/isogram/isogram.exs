defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r{[-\s]}, "")
    |> String.graphemes
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.all?(&(1 == length(&1)))
  end

end
