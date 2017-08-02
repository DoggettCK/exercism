defmodule CollatzConjecture do
  use Bitwise

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(number :: pos_integer) :: pos_integer
  def calc(1), do: 0
  def calc(input) when is_integer(input) and input > 1, do: do_next_calc(input, -1)
  def calc(_), do: raise FunctionClauseError

  def do_calc(1, _, result), do: result
  def do_calc(input, 1, result), do: input |> Kernel.*(3) |> Kernel.+(1) |> do_next_calc(result)
  def do_calc(input, 0, result), do: input |> div(2) |> do_next_calc(result)

  def do_next_calc(next, result), do: do_calc(next, next &&& 1, result + 1 )
end
