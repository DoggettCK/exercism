defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Map) :: map()
  def transform(input) do
    input
    |> Enum.map(fn({k, v}) -> v |> Enum.zip(Stream.cycle([k])) end)
    |> List.flatten
    |> Enum.into(%{}, fn({k, v}) -> {k |> String.downcase, v} end)
  end
end
