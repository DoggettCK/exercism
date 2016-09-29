defmodule Markdown do
  @doc """
  Parses a given string with Markdown syntax and returns the associated HTML for that string.

  ## Examples

  iex> Markdown.parse("This is a paragraph")
  "<p>This is a paragraph</p>"

  iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
  "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """

  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&convert_inline/1)
    |> convert_lines
    |> Enum.join
  end

  defp convert_lines(lines), do: convert_lines(lines, [], false)
  defp convert_lines([], results, false), do: Enum.reverse(results)
  defp convert_lines([], results, true), do: convert_lines([], ["</ul>" | results], false)
  defp convert_lines([<< "* ", _::binary >> = head | tail], results, false), do: convert_lines(tail, [convert_line(head), "<ul>" | results], true)
  defp convert_lines([<< "* ", _::binary >> = head | tail], results, true), do: convert_lines(tail, [convert_line(head) | results], true)
  defp convert_lines([head | tail], results, inside_list), do: convert_lines(tail, [convert_line(head) | results], inside_list)

  defp convert_line("* " <> input), do: "<li>" <> input <> "</li>"
  for {header_level, header_md} <- 1..6 |> Enum.map(&{ &1, String.duplicate("#", &1) <> " " }) do
    defp convert_line(unquote(header_md) <> input), do: "<h#{unquote(header_level)}>" <> input <> "</h#{unquote(header_level)}>"
  end
  defp convert_line(input), do: "<p>" <> input <> "</p>" 
  defp convert_inline(input) do
    input
    |> replace_wrapper("__", "em")
    |> replace_wrapper("_", "i")
  end

  defp replace_wrapper(input, markdown, html), do: String.replace(input, ~r{#{markdown}((?!#{markdown}).+)#{markdown}}, "<#{html}>\\1</#{html}>")
end
