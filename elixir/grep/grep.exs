defmodule Grep do
  @switches [
    case_insensitive: :boolean,
    only_file_names: :boolean,
    line_numbers: :boolean,
    invert_results: :boolean,
    match_entire_line: :boolean
  ]
  @aliases [
    i: :case_insensitive,
    l: :only_file_names,
    n: :line_numbers,
    v: :invert_results,
    x: :match_entire_line
  ]

  @spec grep(String.t, [String.t], [String.t]) :: String.t
  def grep(pattern, flags, files) do
    { :ok, options, match_function } = flags |> parse_options |> build_matcher(pattern)

    files
    |> find_matches(options, match_function, [])
    |> format_output(options, files |> length)
  end

  defp parse_options(flags) do
    with switches = @switches, aliases = @aliases do
      {parsed, _} = flags |> OptionParser.parse!(switches: switches, aliases: aliases)

      parsed |> Enum.into(%{})
    end
  end

  defp build_matcher(options, pattern) do
    pattern_matcher = build_regex(options, pattern)

    match_function = case options do
      %{ invert_results: _ } -> fn line -> !Regex.match?(pattern_matcher, line) end
      _ -> fn line -> Regex.match?(pattern_matcher, line) end
    end

    { :ok, options, match_function }
  end

  defp build_regex(%{ case_insensitive: _, match_entire_line: _ }, pattern), do: ~r/\A#{pattern}\s*\z/i
  defp build_regex(%{ case_insensitive: _ }, pattern), do: ~r/#{pattern}\s*/i
  defp build_regex(%{ match_entire_line: _ }, pattern), do: ~r/\A#{pattern}\s*\z/
  defp build_regex(%{}, pattern), do: ~r/#{pattern}\s*/

  defp find_matches([], _, _, results), do: Enum.reverse(results)
  defp find_matches([file | tail], options, match_function, results) do
    file_results = File.stream!(file)
                   |> Enum.with_index(1)
                   |> find_line_match(file, match_function, results)

    find_matches(tail, options, match_function, file_results)
  end

  defp find_line_match([], _, _, results), do: results
  defp find_line_match([{ line, number } | tail], file, match_function, results) do
    match_results = if apply(match_function, [line]) do
      [ { file, line, number } | results ]
    else
      results
    end

    find_line_match(tail, file, match_function, match_results)
  end

  defp output_format(%{ line_numbers: _ }, file_count) when file_count > 1, do: fn {file, line, number} -> "#{file}:#{number}:#{line}" end
  defp output_format(%{ line_numbers: _ }, _), do: fn {_, line, number} -> "#{number}:#{line}" end
  defp output_format(%{}, file_count) when file_count > 1, do: fn {file, line, _} -> "#{file}:#{line}" end
  defp output_format(%{}, _), do: fn {_, line, _} -> line end

  defp format_output(results, %{ only_file_names: _ }, _) do
    results
    |> Enum.uniq_by(fn {file, _, _} -> file end)
    |> Enum.map(fn {file, _, _} -> "#{file}\n" end)
    |> Enum.join
  end

  defp format_output(results, options, file_count) do
    formatter = output_format(options, file_count)

    results |> Enum.map(&(apply(formatter, [&1]))) |> Enum.join
  end
end
