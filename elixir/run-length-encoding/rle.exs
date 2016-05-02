defmodule RunLengthEncoder do 
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form. 
  "1H1O1R1S1E" => "HORSE" 
  """
  @spec encode(str :: String.t) :: String.t
  def encode(string) do
    string
    |> String.to_char_list
    |> Enum.chunk_by(fn x -> x end)
    |> Enum.map(fn x -> {length(x), Enum.take(x, 1)} end)
    |> Enum.reduce("", fn {count, char}, acc -> acc <> "#{count}#{char}" end)
  end

  @spec decode(str :: String.t) :: String.t
  def decode(string) do
    decode(string, "")
  end

  defp decode("", result), do: result
  
  defp decode(:error, _), do: "Invalid string"
  defp decode({count, <<char::binary-size(1)>> <> rest}, result), do: decode(rest, result <> decode_count(count, char))
  defp decode(string, result) when is_binary(string), do: decode(Integer.parse(string), result)

  defp decode_count(0, _), do: ""
  defp decode_count(count, char) do
    Stream.cycle([char])
    |> Enum.take(count)
    |> Enum.join
  end
end
