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
  defp check_brackets(<<"[", rest::binary>>, history), do: check_brackets(rest, ["[" | history])
  defp check_brackets(<<"]", rest::binary>>, ["[" | history]), do: check_brackets(rest, history)
  defp check_brackets(<<"]", _::binary>>, [_ | _history]), do: false
  defp check_brackets(<<"{", rest::binary>>, history), do: check_brackets(rest, ["{" | history])
  defp check_brackets(<<"}", rest::binary>>, ["{" | history]), do: check_brackets(rest, history)
  defp check_brackets(<<"}", _::binary>>, [_ | _history]), do: false
  defp check_brackets(<<"(", rest::binary>>, history), do: check_brackets(rest, ["(" | history])
  defp check_brackets(<<")", rest::binary>>, ["(" | history]), do: check_brackets(rest, history)
  defp check_brackets(<<")", _::binary>>, [_ | _history]), do: false
  defp check_brackets(<<_::binary-size(1), rest::binary>>, history), do: check_brackets(rest, history)
end
