defmodule LsParse.Parse do
  require LsParse.OS

  def parse(resp) when resp |> is_binary do
    resp
    |> String.split("\n")
    |> Enum.filter(fn
      ""  -> false
      " " -> false
      _   -> true
    end)
    |> parse_lines
  end

  defp parse_lines(["total " <> total | files]) do
    {String.to_integer(total), to_parts(files)}
  end

  defp to_parts(lines) when lines |> is_list do
    lines
    |> Enum.map(&to_parts/1)
  end
  defp to_parts(line) when line |> is_binary do
    line
    |> String.split
    |> Enum.filter(fn
      ""  -> false
      " " -> false
      _   -> true
    end)
  end


end
