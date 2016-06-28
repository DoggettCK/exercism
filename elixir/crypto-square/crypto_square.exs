defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(str) do
    cleaned = str |> clean

    cols = cleaned |> String.length |> columns

    cleaned
    |> String.split("", trim: true)
    |> Enum.chunk(cols, cols, Stream.cycle([""]))
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.join(" ")
  end

  defp clean(str), do: str |> String.downcase |> String.replace(~r{[^a-z0-9]}, "")

  defp columns(n) do
    rows = :math.sqrt(n) |> Float.floor |> round

    columns(n, rows, rows * rows)
  end

  defp columns(n, rows, n), do: rows
  defp columns(_, rows, _), do: rows + 1
end
