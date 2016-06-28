defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    n = number - 1
    pluralized = n |> pluralize("bottle")
    next = n |> next |> pluralize("bottle")

    "#{ pluralized |> String.capitalize } of beer on the wall, #{ pluralized } of beer.\n#{ take(n) }, #{ next } of beer on the wall.\n"
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 100..1) do
    range |> Enum.map(&verse/1) |> Enum.join("\n")
  end

  defp pluralize(0, item), do: "no more #{item}s"
  defp pluralize(1, item), do: "1 #{item}"
  defp pluralize(n, item), do: "#{n} #{item}s"

  defp next(0), do: 99
  defp next(n), do: n - 1

  defp take(0), do: "Go to the store and buy some more"
  defp take(1), do: "Take it down and pass it around"
  defp take(_), do: "Take one down and pass it around"
end
