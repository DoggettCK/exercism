defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a dict of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    # In the real world, would probably use something like poolboy. This just does round-robin
    # assignment of a text to the next worker. If you had 3 workers, and every third text was
    # huge, you'd likely have multiple workers just waiting the majority of the time.
    1..workers
    |> Stream.cycle
    |> Enum.zip(texts)
    |> Enum.group_by(fn {worker_id, _} -> worker_id end)
    |> Enum.map(fn {_, tuples} -> tuples |> Enum.map(&(elem(&1, 1))) |> spawn_worker(self) end)
    |> Enum.map(&worker_result/1)
    |> Enum.reduce(%{}, &merge_maps/2)
  end

  defp spawn_worker(texts, parent) do
    spawn_link fn -> send parent, { self, char_frequency(texts) } end
  end

  defp worker_result(pid) do
    receive do
      { ^pid, result } -> result
    end
  end

  defp char_frequency(texts) do
    texts
    |> Enum.map_join(&String.downcase/1)
    |> String.replace(~r/[\s\-0-9,\.]/, "")
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, &update_count/2)
  end

  defp update_count(char, acc) do
    Map.update(acc, char, 1, &(&1 + 1))
  end

  defp merge_maps(results, acc), do: Map.merge(acc, results, fn _, v1, v2 -> v1 + v2 end)
end
