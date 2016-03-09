defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest. 
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_for(number, 2, [])
  end

  def factors_for(number, _, results) when number < 2, do: results |> Enum.reverse
  def factors_for(number, factor, results) when number < factor, do: results
  def factors_for(number, factor, results) when rem(number, factor) == 0 do
    factors_for(div(number, factor), factor, [factor | results])
  end
  def factors_for(number, factor, results), do: factors_for(number, factor + 1, results)
end
