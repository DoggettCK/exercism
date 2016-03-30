defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do
  defstruct focus: nil, trail: [], root: nil
  @type trail :: { :left, any, BinTree.t, trail } | { :right, any, BinTree.t, trail } | :top

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t) :: Z.t
  def from_tree(bt) do
    %Zipper{focus: bt, root: bt}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t) :: BT.t
  def to_tree(%Zipper{root: root}), do: root

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t) :: any
  def value(%Zipper{focus: focus}) do
    focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t) :: Z.t | nil
  def left(%Zipper{focus: %BinTree{left: nil}}), do: nil
  def left(%Zipper{focus: focus, trail: trail} = z) do
    %Zipper{z | focus: focus.left, trail: [:left | trail]}
  end
  
  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t) :: Z.t | nil
  def right(%Zipper{focus: %BinTree{right: nil}}), do: nil
  def right(%Zipper{focus: focus, trail: trail} = z) do
    %Zipper{z | focus: focus.right, trail: [:right | trail]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t) :: Z.t
  def up(%Zipper{focus: root, root: root, trail: []}), do: nil
  def up(z) do
    new_trail = z.trail |> Enum.drop(1)
    new_focus = get_parent(z.root, new_trail |> Enum.reverse)

    %Zipper{z | focus: new_focus, trail: new_trail}
  end

  defp get_parent(focus, [:left | trail]), do: get_parent(focus.left, trail)
  defp get_parent(focus, [:right | trail]), do: get_parent(focus.right, trail)
  defp get_parent(focus, _), do: focus

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t, any) :: Z.t
  def set_value(z, v), do: update_focus(z, %BinTree { z.focus | value: v })

  @doc """
  Replace the left child tree of the focus node. 
  """
  @spec set_left(Z.t, BT.t) :: Z.t
  def set_left(z, l), do: update_focus(z, %BinTree { z.focus | left: l })
  
  @doc """
  Replace the right child tree of the focus node. 
  """
  @spec set_right(Z.t, BT.t) :: Z.t
  def set_right(z, r), do: update_focus(z, %BinTree { z.focus | right: r })

  defp update_focus(z, new_focus) do
    %Zipper { z | focus: new_focus, root: rebuild_root(z.root, new_focus, z.trail |> Enum.reverse) }
  end

  defp rebuild_root(tree, subtree, []), do: subtree
  defp rebuild_root(tree, subtree, [:left | trail]), do: %BinTree{ tree | left: rebuild_root(tree.left, subtree, trail) }
  defp rebuild_root(tree, subtree, [:right | trail]), do: %BinTree{ tree | right: rebuild_root(tree.right, subtree, trail) }
end
