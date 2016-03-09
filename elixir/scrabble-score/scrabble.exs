defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> to_char_list
    |> Enum.reduce(0, &letter_score/2)
  end

  for {letters, score} <- %{
    'AEIOULNRST' => 1,
    'DG' => 2,
    'BCMP' => 3,
    'FHVWY' => 4,
    'K' => 5,
    'JX' => 8,
    'QZ' => 10
  } do
    for letter <- letters do
      def letter_score(unquote(letter), acc), do: acc + unquote(score)
    end
  end

  def letter_score(_, acc), do: acc
end
