defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.split("", trim: true)
    |> Enum.with_index
    |> Enum.map(&double_evens/1)
    |> Enum.sum
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    0 == number
        |> checksum
        |> rem(10)
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    0..9
    |> Enum.map(&(number <> "#{&1}"))
    |> Enum.filter(&Luhn.valid?/1)
    |> hd
  end

  defp double_evens({n, i}) when rem(i, 2) == 1, do: String.to_integer(n)
  defp double_evens({n, _}), do: (String.to_integer(n) * 2) |> scale
  defp scale(n) when n > 10, do: n - 9
  defp scale(n), do: n
end

