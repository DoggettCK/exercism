defmodule Garden do
  @default_names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]
  @plants [:grass, :clover, :radishes, :violets]

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    info_string
    |> String.split("\n")
    |> Enum.map(fn x -> x |> String.graphemes |> Enum.chunk(2) |> Enum.zip(student_names |> Enum.sort) end)
    |> List.flatten
    |> Enum.reduce(student_names |> Enum.into(%{}, fn name -> {name, []} end), &reduce_plants/2)
    |> Enum.map(fn {k, v} -> { k, v |> Enum.reverse |> List.to_tuple } end)
    |> Enum.into(%{})
  end

  for {plant, char} <- @plants |> Enum.map(&({ &1, &1 |> to_string |> String.first |> String.upcase })) do
    defp plant(unquote(char)), do: unquote(plant)
  end

  defp reduce_plants({plants, student}, acc), do: acc |> add_plants(student, plants)

  defp add_plants(map, _, []), do: map
  defp add_plants(map, student, [h | t]) do
    map |> Map.update(student, [plant(h)], &[plant(h) | &1]) |> add_plants(student, t) 
  end
end
