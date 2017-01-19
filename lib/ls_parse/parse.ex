defmodule LsParse.Parse do
  require LsParse.OS

  def parse(resp) when resp |> is_binary do
    resp
    |> String.split("\n")
    |> filter_empty
    |> parse_lines
  end

  defp parse_lines(["total " <> total | files]) do
    {parse_int(total), to_parts(files)}
  end

  defp to_parts(lines) when lines |> is_list do
    lines
    |> Enum.map(&to_parts/1)
  end
  defp to_parts(line) when line |> is_binary do
    line
    |> String.split
    |> filter_empty
  end

  def parse_int(int) when int |> is_binary do
    case Float.parse(int) do
      {count,  ""} -> round(count)
      {count, "K"} -> round(count * 1.0e3)
      {count, "M"} -> round(count * 1.0e6)
      {count, "G"} -> round(count * 1.0e9)
      {count, "T"} -> round(count * 1.0e12)
      {count, "P"} -> round(count * 1.0e15)
    end
  end

  defp filter_empty(list) do
    list
    |> Enum.filter(fn
      ""  -> false
      " " -> false
      _   -> true
    end)
  end

end
