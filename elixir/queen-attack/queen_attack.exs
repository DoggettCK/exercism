defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @default_positions %{black: {7, 3}, white: {0, 3}}

  @doc """
  Creates a new set of Queens
  """
  @spec new(nil | list) :: Queens.t()
  def new(positions \\ nil) do
    default = struct(Queens, @default_positions)
    queens = struct(default, positions || [])

    if queens.black == queens.white do
      raise ArgumentError
    end

    queens
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board = for x <- 0..7, y <- 0..7, do: {x, y}

    board
    |> Enum.map(&(draw_space(&1, queens)))
    |> Enum.chunk(8)
    |> Enum.map(&(Enum.join(&1, " ")))
    |> Enum.join("\n")
  end

  def draw_space({x, y}, %Queens{black: {x, y}}), do: "B"
  def draw_space({x, y}, %Queens{white: {x, y}}), do: "W"
  def draw_space(_, _), do: "_"

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: {x, _}, white: {x, _}}), do: true
  def can_attack?(%Queens{black: {_, y}, white: {_, y}}), do: true
  def can_attack?(%Queens{black: {bx, by}, white: {wx, wy}}) when abs(bx - wx) == abs(by - wy), do: true
  def can_attack?(_), do: false
end
