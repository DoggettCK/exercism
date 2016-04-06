defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []

  def sorted(%Graph{} = g) do
    %Graph{ g |
      attrs: g.attrs |> Enum.sort,
      nodes: g.nodes |> Enum.sort,
      edges: g.edges |> Enum.sort,
    }
  end
end

defmodule Dot do
  defmacro graph(ast) do
    ast
    |> parse(%Graph{})
    |> Graph.sorted
    |> Macro.escape
  end

  defp parse([do: nil], graph), do: graph
  defp parse([do: ast], graph), do: parse(ast, graph)

  defp parse({:__block__, _, []}, graph), do: graph
  defp parse({:__block__, _, [head | tail]}, graph), do: parse({:__block__, [], tail}, parse(head, graph))

  defp parse({:graph, _, nil}, graph), do: add_attr(graph, [])
  defp parse({:graph, _, [[]]}, graph), do: add_attr(graph, []) 
  defp parse({:graph, _, [kw_val]}, graph), do: add_attr(graph, kw_val)

  defp parse({var, _, nil}, graph), do: add_node(graph, var, [])
  defp parse({var, _, [[]]}, graph), do: add_node(graph, var, [])
  defp parse({var, _, [[kw_val]]}, graph), do: add_node(graph, var, [kw_val])

  defp parse({:--, _, [{v1, _, _}, {v2, _, nil}]}, graph), do: add_edge(graph, v1, v2, [])
  defp parse({:--, _, [{v1, _, _}, {v2, _, [[]]}]}, graph), do: add_edge(graph, v1, v2, [])
  defp parse({:--, _, [{v1, _, _}, {v2, _, [kw_val]}]}, graph), do: add_edge(graph, v1, v2, kw_val)

  defp parse(_, _), do: raise ArgumentError

  defp add_node(graph, var, kw_val), do: Map.update(graph, :nodes, [{var, kw_val}], &[{var, kw_val} | &1])
  defp add_attr(graph, kw_val), do: Map.update(graph, :attrs, kw_val, &(&1 |> Enum.concat(kw_val)))
  defp add_edge(graph, v1, v2, kw_val), do: Map.update(graph, :edges, [{v1, v2, kw_val}], &[{v1, v2, kw_val} | &1])
end
