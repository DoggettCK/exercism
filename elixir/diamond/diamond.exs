defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    line_width = max_width(letter)

    letter
    |> range
    |> Enum.map(&line(&1, line_width))
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  for {char, width} <- ?A..?Z |> Enum.with_index |> Enum.map(fn {c, i} -> {c, 2 * (i + 1) - 1} end) do
    defp max_width(unquote(char)), do: unquote(width)
  end

  defp range(?A), do: [?A]
  defp range(char), do: [?A..char, (char-1)..?A] |> Enum.flat_map(&(&1))

  defp line(?A, max_width) do
    outer = String.duplicate(" ", div(max_width - 1, 2))

    "#{outer}A#{outer}"
  end

  defp line(char, max_width) do
    char_width = max_width(char)

    inner = String.duplicate(" ", char_width - 2)
    outer = String.duplicate(" ", div(max_width - char_width, 2))

    letter = [char] |> to_string
    "#{outer}#{letter}#{inner}#{letter}#{outer}"
  end
end
