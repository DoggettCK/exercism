defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    check_brackets(str, [])
  end

  defp check_brackets(<<>>, []), do: true
  defp check_brackets(<<>>, _), do: false
  for {open, close} <- [{"{", "}"}, {"[", "]"}, {"(", ")"}] do
    defp check_brackets(unquote(open) <> rest, history), do: check_brackets(rest, [unquote(open) | history])
    defp check_brackets(unquote(close) <> rest, [unquote(open) | history]), do: check_brackets(rest, history)
    defp check_brackets(unquote(close) <> _, [_ | _history]), do: false
  end
  defp check_brackets(<<_::binary-size(1), rest::binary>>, history), do: check_brackets(rest, history)
end
