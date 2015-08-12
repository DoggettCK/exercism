defmodule Teenager do
  def hey(phrase) do
    cond do
      is_nil(phrase) or 0 == String.length(String.replace(phrase, ~r/\s/, "")) -> "Fine. Be that way!"
      phrase =~ ~r/\?$/ -> "Sure."
      String.upcase(phrase) == phrase and phrase =~ ~r/\p{L}/ -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
