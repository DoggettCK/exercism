defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  defp count([], acc), do: acc
  defp count([_ | tail], acc), do: count(tail, acc + 1)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: map(l, f, [])
  defp map([], _, acc), do: reverse(acc)
  defp map([head | tail], f, acc), do: map(tail, f, [apply(f, [head]) | acc])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: filter(l, f, [])
  defp filter([], _, acc), do: reverse(acc)
  defp filter([head | tail], f, acc), do: filter([head | tail], f, acc, apply(f, [head]))
  defp filter([head | tail], f, acc, true), do: filter(tail, f, [head | acc])
  defp filter([head | tail], f, acc, false), do: filter(tail, f, acc)

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, apply(f, [head, acc]), f)

  @spec append(list, list) :: list
  def append(a, b), do: append(a, b, [])
  defp append([], [], result), do: reverse(result)
  defp append([], [head | tail], result), do: append([], tail, [head | result])
  defp append([head | tail], b, result), do: append(tail, b, [head | result])

  @spec concat([[any]]) :: [any]
  def concat(ll), do: concat(ll, [])
  defp concat([], result), do: reverse(result)
  defp concat([head | tail], result), do: concat(tail, head, result)
  defp concat(ll, [], result), do: concat(ll, result)
  defp concat(ll, [head | tail], result), do: concat(ll, tail, [head | result]) 
end
