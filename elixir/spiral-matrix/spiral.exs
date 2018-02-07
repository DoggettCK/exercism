defmodule Spiral do
  @directions ~w(right down left up)a

  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []
  def matrix(1), do: [[1]]
  def matrix(dimension) do
    positions = 1..dimension
                |> Enum.flat_map(&[&1, &1])
                |> Enum.reverse()
                |> Enum.drop(1)
                |> Enum.zip(Stream.cycle(@directions))
                |> Enum.reduce(%{position: {-1,0}, last: 0}, &follow_instructions/2)

    for row <- 0..(dimension - 1), col <- 0..(dimension - 1) do
      Map.get(positions, {col, row})
    end
    |> Enum.chunk_every(dimension)

  end

  defp follow_instructions([], acc), do: acc
  defp follow_instructions({steps, direction}, acc) do
    do_instructions(acc, steps, direction)
  end

  defp do_instructions(acc, 0, _), do: acc
  defp do_instructions(%{position: {x, y}} = acc, remaining, :right), do: update(acc, {x + 1, y}, remaining, :right)
  defp do_instructions(%{position: {x, y}} = acc, remaining, :down), do: update(acc, {x, y + 1}, remaining, :down)
  defp do_instructions(%{position: {x, y}} = acc, remaining, :left), do: update(acc, {x - 1, y}, remaining, :left)
  defp do_instructions(%{position: {x, y}} = acc, remaining, :up), do: update(acc, {x, y - 1}, remaining, :up)

  defp update(%{last: last} = acc, new_position, remaining, direction) do
    acc
    |> Map.put(new_position, last + 1)
    |> Map.put(:position, new_position)
    |> Map.put(:last, last + 1)
    |> do_instructions(remaining - 1, direction)
  end
end
