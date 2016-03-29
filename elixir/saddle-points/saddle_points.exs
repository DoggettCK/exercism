defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&row_to_ints/1)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str |> rows |> transpose
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    matrix = rows(str)

    # Using tuples, because they're constant-time lookup using elem,
    # versus linear for Enum.at
    col_mins = matrix
                |> transpose
                #|> Enum.map(&Enum.with_index/1)
                |> Enum.map(&Enum.min/1)
                |> List.to_tuple

    row_maxes = matrix
                #|> Enum.map(&Enum.with_index/1)
                |> Enum.map(&Enum.max/1)
                |> List.to_tuple

    col_count = tuple_size(col_mins)
    row_count = tuple_size(row_maxes)

    matrix_tuples = matrix
                    |> Enum.map(&List.to_tuple/1)
                    |> List.to_tuple

    (for i <- 0..(row_count-1), j <- 0..(col_count-1), do: {i, j})
    |> Enum.filter(fn {i, j} -> elem(col_mins, j) == elem(row_maxes, i) and elem(row_maxes, i) == (matrix_tuples |> elem(i) |> elem(j)) end)
  end

  defp row_to_ints(row_str) do
    row_str
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp transpose(list_of_lists) do
    list_of_lists
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
end

