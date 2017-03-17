defmodule OCRNumbers do

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t]) :: String.t
  def convert(input) do
    height_multiple_of_4 = input |> length |> rem(4) |> Kernel.==(0)
    width_multiple_of_3 = input |> Enum.all?(fn line -> line |> String.length |> rem(3) |> Kernel.==(0) end)

    case { height_multiple_of_4, width_multiple_of_3 } do
      { false, _ } -> { :error, 'invalid line count' }
      { _, false } -> { :error, 'invalid column count' }
      _ -> { :ok, input |> Enum.chunk(4) |> do_convert([]) }
    end
  end

  @ocr_digits [
    [" _ ",
     "| |",
     "|_|",
     "   "],
    ["   ",
     "  |",
     "  |",
     "   "],
    [" _ ",
     " _|",
     "|_ ",
     "   "],
    [" _ ",
     " _|",
     " _|",
     "   "],
    ["   ",
     "|_|",
     "  |",
     "   "],
    [" _ ",
     "|_ ",
     " _|",
     "   "],
    [" _ ",
     "|_ ",
     "|_|",
     "   "],
    [" _ ",
     "  |",
     "  |",
     "   "],
    [" _ ",
     "|_|",
     "|_|",
     "   "],
    [" _ ",
     "|_|",
     " _|",
     "   "]
  ]

  for {ocr_digit, decimal_digit} <- @ocr_digits |> Enum.with_index do
    defp ocr_to_decimal(unquote(ocr_digit)), do: unquote(decimal_digit |> to_string)
  end
  defp ocr_to_decimal(_), do: "?"

  defp do_convert([], results), do: results |> Enum.reverse |> Enum.join(",")
  defp do_convert([ocr_line | tail], results), do: do_convert(tail, [ocr_line |> to_digits | results])

  defp to_digits(ocr_line) do
    ocr_line
    |> Enum.map(&to_chunks/1)
    |> List.zip
    |> Enum.map_join(&tuple_to_digit/1)
  end

  defp to_chunks(single_line) do
    single_line
    |> String.graphemes
    |> Enum.chunk(3)
  end

  defp tuple_to_digit(line_tuple) do
    line_tuple
    |> Tuple.to_list
    |> Enum.map(&Enum.join/1)
    |> ocr_to_decimal
  end
end
