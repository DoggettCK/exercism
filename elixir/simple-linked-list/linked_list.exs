defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    list |> Tuple.insert_at(0, elem)
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    tuple_size(list)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    LinkedList.length(list) == 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    case LinkedList.length(list) do
      0 -> { :error, :empty_list }
      _ -> { :ok, elem(list, 0) }
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    case LinkedList.length(list) do
      0 -> { :error, :empty_list }
      _ -> { :ok, Tuple.delete_at(list, 0) }
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    case LinkedList.length(list) do
      0 -> { :error, :empty_list }
      _ -> { :ok, elem(list, 0), Tuple.delete_at(list, 0) }
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    List.to_tuple(list)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    Tuple.to_list(list)
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: reverse(list, LinkedList.new())

  defp reverse({}, results), do: results
  defp reverse(list, results) do
    {:ok, head, tail} = list |> LinkedList.pop
    reverse(tail, results |> LinkedList.push(head))
  end
end
