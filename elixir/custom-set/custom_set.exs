defmodule CustomSet do
  # This lets the compiler check that all Set callback functions have been
  # implemented.
  @behaviour Set

  # TODO: Just use a Dict internally
  defstruct set: [] 

  def new(members \\ []) do
    members |> Enum.to_list |> from_list
  end

  def delete(%CustomSet{} = set, value) do
    set |> to_dict |> Map.delete(value) |> from_dict
  end

  def equal?(%CustomSet{} = set1, %CustomSet{} = set2) do
    difference(set1, set2)
    |> size
    |> Kernel.==(0)
  end

  def difference(%CustomSet{} = set1, %CustomSet{} = set2) do
    set1
    |> to_dict
    |> remove_keys(set2 |> to_dict |> Map.keys)
    |> from_dict
  end

  defp remove_keys(map, []), do: map
  defp remove_keys(map, [head | tail]), do: remove_keys(map |> Map.delete(head), tail)

  def size(%CustomSet{set: set}) do
    set |> length
  end

  def disjoint?(%CustomSet{} = set1, %CustomSet{} = set2) do
    [set1, set2]
    |> Enum.sort(&sort_sets_by_size/2)
    |> Enum.map(&to_dict/1)
    |> do_disjoint?
  end

  defp sort_sets_by_size(%CustomSet{} = set1, %CustomSet{} = set2), do: size(set1) < size(set2)

  defp do_disjoint?([smaller_dict, larger_dict]) do
    smaller_dict
    |> Map.keys
    |> Enum.map(fn k -> Map.has_key?(larger_dict, k) end)
    |> Enum.any?
    |> Kernel.not
  end

  def empty(%CustomSet{}), do: new

  def intersection(%CustomSet{} = set1, %CustomSet{} = set2) do
    [set1, set2]
    |> Enum.sort(&sort_sets_by_size/2)
    |> Enum.map(&to_dict/1)
    |> do_intersection
    |> from_dict
  end

  defp do_intersection([smaller_dict, larger_dict]) do
    larger_dict |> Map.take(smaller_dict |> Map.keys)
  end

  def member?(%CustomSet{} = set, value) do
    set |> to_dict |> Map.has_key?(value)
  end

  def put(%CustomSet{} = set, value) do
    set |> to_dict |> Map.put(value, true) |> from_dict
  end

  def subset?(%CustomSet{set: set1}, %CustomSet{} = set2) do
    dict2 = set2 |> to_dict
    set1 |> Enum.all?(fn k -> Map.has_key?(dict2, k) end)
  end

  def union(%CustomSet{} = set1, %CustomSet{} = set2) do
    [set1, set2]
    |> Enum.map(&to_dict/1)
    |> Enum.reduce(%{}, fn(x, acc) -> Map.merge(acc, x, fn k, _, _ -> {k, true} end) end)
    |> from_dict
  end

  def to_list(%CustomSet{set: set}), do: set

  defp from_list(list \\ []) when is_list(list) do
    list |> Enum.into(%{}, fn x -> {x, true} end) |> from_dict
  end

  defp from_dict(dict) when is_map(dict) do
    %CustomSet{set: dict |> Map.keys |> Enum.sort}
  end

  defp to_dict(%CustomSet{} = set) do
    set.set |> Enum.into(%{}, fn x -> {x, true} end)
  end

  defimpl Inspect do
    import Inspect.Algebra

    def inspect(%CustomSet{set: set}, opts) do
      concat ["%CustomSet{list: ", Inspect.List.inspect(set, opts), "}"]
    end
  end
end
