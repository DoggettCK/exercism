defmodule WeightedQuickUnionFind do
  @doc """
  Basic Union-Find algorithm from http://algs4.cs.princeton.edu/15uf/
  Take the course for free at https://www.coursera.org/course/algs4partI
  """
  defstruct id: [], sz: []

  def initialize(n) when n > 0 do
    %WeightedQuickUnionFind {
      id: 0..(n-1) |> Enum.to_list |> List.to_tuple,
      sz: [1] |> Stream.cycle |> Enum.take(n) |> List.to_tuple
    }
  end

  defp root(id, i), do: root(id, i, elem(id, i))
  defp root(_id, i, i), do: i
  defp root(id, i, _id_i), do: root(id, elem(id, i), i)

  def connected?(uf, p, q), do: root(uf.id, p) == root(uf.id, q)

  # Modified version of root to do path compression on insert
  # and make lookup trees much shallower/faster.
  # Sedgewick's version does this in root, but modifies the structure
  # on each lookup, so I've modified it to do it on insertion, so
  # I believe it will eventually yield the same performance, depending
  # on how connected the resulting graph becomes.
  defp compress_paths(id, i), do: compress_paths(id, i, elem(id, i))
  defp compress_paths(id, i, i), do: {id, i}
  defp compress_paths(id, i, _id_i) do
    grandparent = elem(id, elem(id, i))

    compress_paths(id |> tuple_set(i, grandparent), grandparent, i)
  end

  def union(uf, p, q) do
    { id, i } = compress_paths(uf.id, p)
    { id, j } = compress_paths(id, q)
    { id, sz } = union_update(id, uf.sz, i, j)

    %WeightedQuickUnionFind { uf | id: id, sz: sz }
  end

  defp union_update(id, sz, i, j) when i == j, do: {id, sz}
  defp union_update(id, sz, i, j) when elem(sz, i) >= elem(sz, j) do
    new_size = [i, j] |> Enum.map(fn x -> elem(sz, x) end) |> Enum.sum

    { id |> tuple_set(j, i), sz |> tuple_set(i, new_size) }
  end
  defp union_update(id, sz, i, j), do: union_update(id, sz, j, i)

  defp tuple_set(tuple, index, value), do: tuple |> Tuple.delete_at(index) |> Tuple.insert_at(index, value)
end

defmodule Connect do
  @doc """
  Calculates the winner (if any) of a board using "O" as the white player and "X" as the black player
  """
  @spec result_for([String.t]) :: :none | :black | :white
  def result_for(["O"]), do: :white
  def result_for(["X"]), do: :black
  def result_for(board) do
    white_wins = board |> clean(:white) |> board_size |> winner?(:white)
    black_wins = board |> clean(:black) |> transpose |> board_size |> winner?(:black)

    result_for(white_wins, black_wins)
  end

  defp result_for(true, _), do: :white
  defp result_for(_, true), do: :black
  defp result_for(_, _), do: :none

  defp winner?({board, cols, rows}, color) do
    n = cols * rows
    {fake_enter, fake_exit} = {n, n + 1}

    # Treat the problem as a union-find percolation problem
    # http://algs4.cs.princeton.edu/15uf/
    uf = WeightedQuickUnionFind.initialize(n + 2)
    uf = 0..(cols-1) |> Enum.reduce(uf, fn(x, acc) -> WeightedQuickUnionFind.union(acc, n, x) end)
    uf = (n-cols)..(n-1) |> Enum.reduce(uf, fn(x, acc) -> WeightedQuickUnionFind.union(acc, n + 1, x) end)

    (for y <- 0..(rows-1), x <- 0..(cols-1), do: {x, y})
    |> Enum.filter(&is_color?(&1, board, color)) # find all cells with current color
    |> Enum.map(fn {x, y} -> {{x, y}, neighbors({x, y}, {cols, rows}) |> Enum.filter(&is_color?(&1, board, color)), cols} end) # get a list of valid neighbors per cell of the same color
    |> Enum.reduce(uf, &link_neighbors/2)
    |> WeightedQuickUnionFind.connected?(fake_enter, fake_exit)
  end

  # Reduce method to link a cell to each of the neighbor cells specified in a list
  defp link_neighbors({_, [], _}, uf), do: uf
  defp link_neighbors({{x, y}, [{nx, ny} | tail], cols}, uf), do: link_neighbors({{x, y}, tail, cols}, WeightedQuickUnionFind.union(uf, y * cols + x, ny * cols + nx))

  defp is_color?({x, y}, board, :white), do: "O" == board |> elem(y) |> elem(x)
  defp is_color?({x, y}, board, :black), do: "X" == board |> elem(y) |> elem(x)

  # Convert list of strings to 2D tuple containing either a space or the piece we're looking for ("O" or "X")
  defp clean(board, :white), do: clean(board, "O")
  defp clean(board, :black), do: clean(board, "X")
  defp clean(board, piece), do: board |> Enum.map(&clean_row_to_tuple(&1, piece)) |> List.to_tuple

  # Compress original row, then change anything that's not the piece passed in ("O" or "X") to a space, 
  defp clean_row_to_tuple(row, piece), do: row |> String.replace(~r/\s/, "") |> String.replace(~r/[^#{piece}]/, " ") |> String.split("", trim: true) |> List.to_tuple

  # For black, we want to transpose the board, so we can do the same fake-top-to-fake-bottom percolation check
  defp transpose(board), do: board |> Tuple.to_list |> List.zip |> List.to_tuple

  defp board_size(board) when is_tuple(board) do
    {board, board |> elem(0) |> tuple_size, board |> tuple_size}
  end

  # Get a list of neighbors on a rhombus-shaped hexagonal map
  # http://www.redblobgames.com/grids/hexagons/ 
  def neighbors({x, y}, {width, height}) do
    [{x, y - 1}, {x + 1, y - 1}, {x - 1, y}, {x + 1, y}, {x - 1, y + 1}, {x, y + 1}]
    |> Enum.filter(&(valid_neighbor?(&1, {width, height})))
    |> Enum.sort
  end

  defp valid_neighbor?({x, y}, _) when x < 0 or y < 0, do: false
  defp valid_neighbor?({x, y}, {width, height}) when x >= width or y >= height, do: false
  defp valid_neighbor?(_, _), do: true
end
