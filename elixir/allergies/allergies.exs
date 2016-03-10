defmodule Allergies do
  use Bitwise

  @allergens ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]

  for {allergen, index} <- @allergens |> Enum.with_index do
    defp flag_set?(flags, unquote(allergen)) do
      (flags &&& (:math.pow(2, unquote(index)) |> round)) == (:math.pow(2, unquote(index)) |> round)
    end
  end

  defp flag_set?(_, _), do: false

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    @allergens
    |> Enum.filter(&(flag_set?(flags, &1)))
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    flag_set?(flags, item |> String.downcase)
  end
end
