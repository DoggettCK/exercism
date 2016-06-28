defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer("What is " <> question) do
    question
    |> String.replace("multiplied by", "*")
    |> String.replace("divided by", "/")
    |> String.replace("plus", "+")
    |> String.replace("minus", "-")
    |> String.replace(~r{[^-+*/0-9a-zA-Z]}, " ")
    |> String.strip
    |> String.split(~r{\s+})
    |> parse
  end
  def answer(_), do: raise ArgumentError

  defp parse([result]), do: String.to_integer(result)
  defp parse([x, "+", y | t]), do: parse([(String.to_integer(x) + String.to_integer(y)) |> to_string | t]) 
  defp parse([x, "-", y | t]), do: parse([(String.to_integer(x) - String.to_integer(y)) |> to_string | t]) 
  defp parse([x, "*", y | t]), do: parse([(String.to_integer(x) * String.to_integer(y)) |> to_string | t]) 
  defp parse([x, "/", y | t]), do: parse([div(String.to_integer(x), String.to_integer(y)) |> to_string | t]) 
  defp parse(_), do: raise ArgumentError
end
