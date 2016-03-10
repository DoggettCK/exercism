defmodule Atbash do
  for {p, c} <- Enum.zip(?a..?z, ?z..?a) do
    defp encode_char(unquote(p)), do: unquote(c)
  end

  defp encode_char(p), do: p 

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.replace(~r/\W/, "")
    |> to_char_list
    |> Enum.map(&encode_char/1)
    |> Enum.chunk(5, 5, [""])
    |> Enum.map_join(" ", &to_string/1)
  end
end
