defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r{[^\w]}, trim: true)
    |> Enum.flat_map(&split_camel_case/1)
    |> Enum.map(&String.first/1)
    |> Enum.join
    |> String.upcase
  end

  defp split_camel_case(string) do
    string
    |> String.split(~r{(?<!^)(?=[A-Z])}, trim: true)
  end
end
