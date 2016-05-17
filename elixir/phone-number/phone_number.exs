defmodule Phone do
  @invalid "0000000000"

  @numbers ~w(0 1 2 3 4 5 6 7 8 9)
  @valid_non_numeric ["+", "-", " ", ".", "(", ")"]

  @spec number(String.t) :: String.t
  def number(raw) do
    clean(raw)
  end

  defp clean(raw), do: clean(raw, "", 0)
  defp clean(<<>>, "1" <> result, 11), do: result
  defp clean(<<>>, result, 10), do: result
  defp clean(<<>>, _, _), do: @invalid
  
  for num <- @numbers do
    defp clean(unquote(num) <> rest, result, num_count), do: clean(rest, result <> "#{unquote(num)}", num_count + 1)
  end

  for char <- @valid_non_numeric do
    defp clean(unquote(char) <> rest, result, num_count), do: clean(rest, result, num_count)
  end

  defp clean(_raw, _result, _num_count), do: @invalid

  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    {area, _, _} = chunks(raw)
    area
  end

  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    {area, prefix, suffix} = chunks(raw)
    "(#{area}) #{prefix}-#{suffix}"
  end

  defp chunks(raw) do
    Regex.scan(~r/(\d{3})(\d{3})(\d{4})/, raw |> number, capture: :all_but_first)
                                              |> hd
                                              |> List.to_tuple
  end
end
