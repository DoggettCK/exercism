defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    match(base, candidates, [])
  end

  defp match(_, [], results), do: results |> Enum.reverse
  defp match(base, [head | tail], results) do
    match(base, tail, anagram?(base, head, results))
  end

  defp anagram?(base, head, results) do
    clean_base = base |> clean
    clean_head = head |> clean

    anagram?(base, head, clean_base, clean_head, clean_base |> sort, clean_head |> sort, results)
  end

  defp anagram?(_, _, clean_base, clean_head, _, _, results)  when clean_base === clean_head, do: results
  defp anagram?(_, head, _, _, sorted_clean_base, sorted_clean_head, results) when sorted_clean_base === sorted_clean_head, do: [head | results]
  defp anagram?(_, _, _, _, _, _, results), do: results

  defp clean(string) when is_binary(string) do
    string
    |> String.downcase
  end

  defp sort(string) when is_binary(string) do
    string
    |> to_char_list
    |> Enum.sort
    |> to_string
  end
end
