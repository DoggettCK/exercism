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
    |> Enum.reduce("", fn str, acc -> acc <> "#{length(str)}#{Enum.take(str, 1)}" end)
  end

  @spec decode(str :: String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/(\d+)(\w)/, string, capture: :all_but_first)
    |> Enum.map(fn [count, char] -> String.duplicate(char, String.to_integer(count)) end)
    |> Enum.join
  end
end
