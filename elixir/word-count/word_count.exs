defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map()
  def count(sentence) do
    sentence
    |> String.split(~r/[!@%$^&* _,:]+/, trim: true)
    |> Enum.map(&String.downcase/1)
    |> Enum.reduce(%{}, &increment_word_count/2)
  end

  defp increment_word_count(word, acc), do: Dict.update(acc, word, 1, &(&1 + 1))
end
