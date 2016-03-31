defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]), do: []
  def annotate(board) do
    { col_count, row_count } = board_size(board)

    board_1d = Enum.join(board)
                |> String.split("", trim: true)
                |> Enum.with_index

    mines = board_1d
            |> Enum.filter(&mine?/1)
            |> Enum.into(%{}, fn {_, i} -> {i, 1} end)

    board_1d
    |> calculate_surrounding(col_count, row_count, mines)
    |> Enum.chunk(col_count)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&(String.replace(&1, "0", " ")))
  end

  defp calculate_surrounding(char_index_pairs, col_count, row_count, mines), do: calculate_surrounding(char_index_pairs, col_count, row_count, mines, [])
  defp calculate_surrounding([], _, _, _, results), do: results |> Enum.reverse
  defp calculate_surrounding([{"*", _} | tail], col_count, row_count, mines, results), do: calculate_surrounding(tail, col_count, row_count, mines, ["*" | results])
  defp calculate_surrounding([{" ", index} | tail], col_count, row_count, mines, results) do
    {x, y} = to_2d(index, col_count)

    calculate_surrounding(tail, col_count, row_count, mines,
    [neighbors(x, y, col_count, row_count)
      |> Enum.map(fn i -> Map.get(mines, i, 0) end)
      |> Enum.sum
      |> to_string | results])
  end


  defp to_1d(list_of_2d_pts, col_count), do: to_1d(list_of_2d_pts, col_count, [])
  defp to_1d([], _, results), do: results |> Enum.reverse
  defp to_1d([{x, y} | tail], col_count, results), do: to_1d(tail, col_count, [y * col_count + x | results])
  defp to_2d(index, col_count), do: { rem(index, col_count), div(index, col_count)}

  defp mine?({"*", _}), do: true
  defp mine?(_), do: false

  defp board_size([]), do: { 0, 0 }
  defp board_size(list_of_lists), do: { list_of_lists |> hd |> String.length, list_of_lists |> length }

  # single column
  defp neighbors(0, 0, 1, _), do: [{0, 1}] |> to_1d(1)
  defp neighbors(0, y, 1, rc) when y == (rc - 1), do: [{0, y - 1}] |> to_1d(1)
  defp neighbors(0, y, 1, _), do: [{0, y - 1}, {0, y + 1}] |> to_1d(1)

  # single row
  defp neighbors(0, 0, cc, 1), do: [{1, 0}] |> to_1d(cc)
  defp neighbors(x, 0, cc, 1) when x == (cc - 1), do: [{x - 1, 0}] |> to_1d(cc)
  defp neighbors(x, 0, cc, 1), do: [{x - 1, 0}, {x + 1, 0}] |> to_1d(cc)

  # top left
  defp neighbors(0, 0, cc, _), do: [{1, 0}, {0, 1}, {1, 1}] |> to_1d(cc)
  # top right
  defp neighbors(x, 0, cc, _) when x == (cc - 1), do: [{x - 1, 0}, {x - 1, 1}, {x, 1}] |> to_1d(cc)
  # bottom left
  defp neighbors(0, y, cc, rc) when y == (rc - 1), do: [{1, y}, {0, y - 1}, {1, y - 1}] |> to_1d(cc)
  # bottom right
  defp neighbors(x, y, cc, rc) when x == (cc - 1) and y == (rc - 1), do: [{x - 1, y - 1}, {x - 1, y}, {x, y - 1}] |> to_1d(cc)
  # top edge
  defp neighbors(x, 0, cc, _), do: [{x - 1, 0}, {x + 1, 0}, {x - 1, 1}, {x, 1}, {x + 1, 1}] |> to_1d(cc)
  # bottom edge
  defp neighbors(x, y, cc, rc) when y == (rc - 1), do: [{x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1}, {x - 1, y}, {x + 1, y}] |> to_1d(cc)
  # left edge
  defp neighbors(0, y, cc, _), do: [{0, y - 1}, {1, y - 1}, {1, y}, {0, y + 1}, {1, y + 1}] |> to_1d(cc)
  # right edge
  defp neighbors(x, y, cc, _) when x == (cc - 1), do: [{x - 1, y - 1}, {x, y - 1}, {x - 1, y}, {x - 1, y + 1}, {x, y + 1}] |> to_1d(cc)
  # anywhere else
    defp neighbors(x, y, cc, _), do: [{x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1}, {x - 1, y}, {x + 1, y}, {x - 1, y + 1}, {x, y + 1}, {x + 1, y + 1}] |> to_1d(cc)
  end
