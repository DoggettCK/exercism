defmodule Teenager do
  @silence ~r/^\s*$/
  @question ~r/\?$/
  @has_letters ~r/\p{L}/u

  def hey(nil), do: "Fine. Be that way!" 
  def hey(phrase) do
    [silence, question, has_letters] = [@silence, @question, @has_letters] |> Enum.map(&(phrase =~ &1))

    interpret(silence, question, has_letters, String.upcase(phrase) == phrase)
  end

  defp interpret(true, _question, _has_letters, _loud), do: "Fine. Be that way!"
  defp interpret(_silence, true, _has_letters, _loud), do: "Sure."
  defp interpret(_silence, _question, yelling, yelling), do: "Whoa, chill out!"
  defp interpret(_, _, _, _), do: "Whatever."
end
