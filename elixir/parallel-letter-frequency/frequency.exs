defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> Enum.map_join(&String.downcase/1)
    |> String.replace(~r/[\s\-0-9,\.]/, "")
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, &update_count/2)
  end

  defp update_count(char, acc) do
    Map.update(acc, char, 1, &(&1 + 1))
  end
end
