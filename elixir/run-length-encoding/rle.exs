defmodule RunLengthEncoder do 
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form. 
  "1H1O1R1S1E" => "HORSE" 
  """
  @spec encode(string) :: String.t
  def encode(string) do
    encode(string, "", 0, "")
  end

  defp encode("", "", 0, _), do: ""
  defp encode("", prev, count, result) do
    result <> encode_count(count, prev)
  end

  defp encode(<<prev::binary-size(1)>> <> rest, prev, count, result) do
    encode(rest, prev, count + 1, result)
  end

  defp encode(<<new::binary-size(1)>> <> rest, prev, count, result) do
    encode(rest, new, 1, result <> encode_count(count, prev))
  end

  defp encode_count(0, _), do: ""
  defp encode_count(count, char), do: "#{count}#{char}"

  @spec decode(string) :: String.t
  def decode(string) do
    decode(string, "")
  end

  defp decode("", result), do: result
  
  defp decode(string, result) do
    case Integer.parse(string) do
      {count, <<char::binary-size(1)>> <> rest} ->
        decode(rest, result <> decode_count(count, char))
      :error ->
        "Invalid string"
    end
  end

  defp decode_count(0, _), do: ""
  defp decode_count(count, char) do
    Stream.cycle([char])
    |> Enum.take(count)
    |> Enum.join
  end
end
