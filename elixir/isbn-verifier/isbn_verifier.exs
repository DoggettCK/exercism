defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    case Regex.match?(~r/\A\d-?\d{3}-?\d{5}-?[X0-9]\z/, isbn) do
      false -> false
      true -> 
        isbn
        |> String.replace("-", "")
        |> String.graphemes()
        |> Enum.map(&to_numbers/1)
        |> Enum.zip(10..1)
        |> Enum.map(fn {a, b} -> a * b end)
        |> Enum.sum()
        |> Kernel.rem(11)
        |> Kernel.==(0)
    end
  end

  defp to_numbers("X"), do: 10
  defp to_numbers(x), do: String.to_integer(x)
end
