defmodule RailFenceCipher do
  @encode_dummy "@" # dummy character for empty spaces
  @decode_dummy "*"

  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) do
    str
    |> build_zigzag_stream(rails)
    |> build_columns
    |> transpose_list
    |> flatten_to_string
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode(str, rails) do
    str
    |> String.replace(~r{.}, @decode_dummy)
    |> build_zigzag_stream(rails)
    |> build_columns
    |> transpose_list
    |> map_decode(str)
    |> transpose_list
    |> flatten_to_string
  end

  defp flatten_to_string(list_of_lists), do: list_of_lists |> Enum.join |> String.replace(@encode_dummy, "")

  defp transpose_list(list) when is_list(list), do: list |> List.zip |> Enum.map(&Tuple.to_list/1)

  defp map_decode(list_of_lists, str), do: map_decode(list_of_lists, str, [], [])
  defp map_decode([], _, _, results), do: Enum.reverse(results)
  defp map_decode([[] | rest], str, current, results), do: map_decode(rest, str, [], [Enum.reverse(current) | results])
  defp map_decode([[@decode_dummy | t] | rest], <<char::binary-size(1), str::binary>>, current, results), do: map_decode([t | rest], str, [char | current], results)
  defp map_decode([[h | t] | rest], str, current, results), do: map_decode([t | rest], str, [h | current], results)

  defp build_columns(list), do: build_columns(list, [])
  defp build_columns([], results), do: Enum.reverse(results)
  defp build_columns([{char, row, rows} | t], results) do
    build_columns(t, [build_column(char, row, rows) | results])
  end

  defp build_column(char, row, rows) do
    String.duplicate(@encode_dummy, rows)
    |> String.split("", trim: true)
    |> List.to_tuple
    |> Tuple.delete_at(row)
    |> Tuple.insert_at(row, char)
  end

  defp build_zigzag_stream(str, rails) do
    str
    |> String.split("", trim: true)
    |> Enum.zip(zigzag_stream(rails - 1))
    |> Enum.map(&(Tuple.append(&1, rails)))
  end

  defp zigzag_stream(x) do
    [min, max] = Enum.sort([0, x])

    zigzag_stream(min, max)
  end
  defp zigzag_stream(x, x), do: Stream.cycle([x])
  defp zigzag_stream(min, max) do
    Stream.resource(fn -> { min, true } end,
    fn { next, going_up } ->
      case { next, going_up } do
        { ^max, true } -> { [next], { next - 1, false } }
        { ^min, false } -> { [next], { next + 1, true } }
        { _, true } -> { [next], { next + 1, true } }
        { _, false } -> { [next], { next - 1, false } }
        _ -> { :halt, nil }
      end
    end,
    fn _ -> nil end)
  end
end
