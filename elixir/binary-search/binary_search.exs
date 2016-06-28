defmodule BinarySearch do
  @doc """
  Searches for a key in the list using the binary search algorithm.
  It returns :not_found if the key is not in the list.
  Otherwise returns the tuple {:ok, index}.

  ## Examples

  iex> BinarySearch.search([], 2)
  :not_found

  iex> BinarySearch.search([1, 3, 5], 2)
  :not_found

  iex> BinarySearch.search([1, 3, 5], 5)
  {:ok, 2}

  """

  @spec search(Enumerable.t, integer) :: {:ok, integer} | :not_found
  def search([], _), do: :not_found
  def search([key], key), do: { :ok, 0 }
  def search(list, key) do
    validate_search(list, Enum.sort(list), key)
  end

  def validate_search(list, list, key), do: binary_search(list |> List.to_tuple, key, 0, length(list) - 1, div(length(list) - 1, 2))
  def validate_search(_, _, _), do: raise ArgumentError, message: "expected list to be sorted"

  def binary_search(tuple, key, min, min, _) when elem(tuple, min) == key, do: { :ok, min }
  def binary_search(_, _, min, min, _), do: :not_found
  def binary_search(tuple, key, _, _, middle) when elem(tuple, middle) == key, do: { :ok, middle }
  def binary_search(tuple, key, min, _, middle) when elem(tuple, middle) > key, do: binary_search(tuple, key, min, middle - 1, min + div(middle - min - 1, 2))
  def binary_search(tuple, key, _, max, middle), do: binary_search(tuple, key, middle + 1, max, middle + div(max - middle, 2))
end
