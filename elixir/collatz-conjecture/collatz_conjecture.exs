defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(number :: pos_integer) :: pos_integer
  def calc(input) when is_integer(input) and input > 0, do: do_calc(input, 0)
  def calc(_), do: raise FunctionClauseError

  def do_calc(1, result), do: result
  def do_calc(input, result) when rem(input, 2) == 1, do: input |> Kernel.*(3) |> Kernel.+(1) |> do_calc(result + 1)
  def do_calc(input, result), do: input |> div(2) |> do_calc(result + 1)
end
