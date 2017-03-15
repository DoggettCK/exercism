defmodule Say do
  @mods %{
    1_000_000_000 => "billion",
    1_000_000 => "million",
    1_000 => "thousand"
  }

  @lookup %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t}
  def in_english(number) when number < 0, do: { :error, "number is out of range" }
  def in_english(number) when number >= 1_000_000_000_000, do: { :error, "number is out of range" }
  def in_english(0), do: { :ok, "zero" }
  def in_english(number), do: {:ok, number |> split_thousands([]) |> to_words([]) }

  # Split a number up at every factor of 1000 into a tuple of its magnitude and text
  defp split_thousands(0, results), do: results

  # Doesn't seem to respect insertion order for this one without sort, but does for the other
  for {mod, word} <- @mods |> Enum.sort(fn {k1, _}, {k2, _} -> k1 >= k2 end) do
    defp split_thousands(number, results) when number >= unquote(mod) do
      divisor = div(number, unquote(mod))
      remainder = rem(number, unquote(mod))

      split_thousands(remainder, [{ divisor, unquote(word |> to_string)} | results])
    end
  end
  defp split_thousands(number, results), do: split_thousands(0, [{ number, '' } | results])

  # Convert a number to hundreds, tens, and ones, appending the thousands/millions/billions after
  defp to_words([], results), do: results |> Enum.join(" ") |> String.trim
  defp to_words([{0, _text} | tail], results), do: to_words(tail, results)
  defp to_words([{number, text} | tail], results) do
      hundreds = div(number, 100)
      under_hundred = rem(number, 100)
      tens = div(under_hundred, 10)
      ones = rem(under_hundred, 10)

      english = under_thousand(hundreds, tens, ones)

      to_words(tail, ["#{english} #{text}" | results])
  end

  # Convert any number under 1000 to words from the lookup table
  defp under_thousand(0, 0, 0), do: ""

  for {mod, word} <- @lookup |> Enum.filter(fn {mod, _} -> mod < 20 end) do
    defp under_thousand(0, unquote(div(mod, 10)), unquote(rem(mod, 10))), do: unquote(word)
  end

  for {mod, word} <- @lookup |> Enum.filter(fn {mod, _} -> mod >= 20 end) do
    defp under_thousand(0, unquote(div(mod, 10)), 0), do: unquote(word)
    defp under_thousand(0, unquote(div(mod, 10)), ones), do: "#{unquote(word)}-#{under_thousand(0, 0, ones)}"
  end

  defp under_thousand(hundreds, tens, ones) do
    "#{under_thousand(0, 0, hundreds)} hundred #{under_thousand(0, tens, ones)}" |> String.trim
  end
end

