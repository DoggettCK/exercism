defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string :: String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/\b\w|\p{Lu}/, string)
    |> Enum.join
    |> String.upcase
  end
end
