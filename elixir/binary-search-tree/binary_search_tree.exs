defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: tree_data, left: nil} = tree, data) when data <= tree_data, do: Map.put(tree, :left, new(data))
  def insert(%{data: tree_data} = tree, data) when data <= tree_data, do: Map.put(tree, :left, insert(tree.left, data))
  def insert(%{right: nil} = tree, data), do: Map.put(tree, :right, new(data))
  def insert(%{} = tree, data), do: Map.put(tree, :right, insert(tree.right, data))

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    do_in_order(tree, [])
  end

  defp do_in_order(nil, results), do: results
  defp do_in_order(%{data: data, left: nil, right: nil}, results), do: results ++ [data]
  defp do_in_order(%{data: data} = tree, results) do
    do_in_order(tree.right, do_in_order(tree.left, results) ++ [data])
  end
end
