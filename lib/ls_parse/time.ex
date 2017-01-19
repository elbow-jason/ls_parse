defmodule LsParse.Time do

  def parse(time) when time |> is_binary do
    time
    |> String.split(":")
    |> parse_time_parts
  end

  defp parse_time_parts([hr, min, sec]) do
    {sec, microsec} = sec_parts(sec)
    %{
      hour:   hr |> String.to_integer,
      minute: min |> String.to_integer,
      second: sec,
      microsecond: microsec,
    }
  end

  defp sec_parts(sec) when is_binary(sec) do
    case String.split(sec, ".") do
      [s, ms] ->
        micro =
          ms
          |> String.slice(0, 6)
          |> String.to_integer
        {String.to_integer(s), {micro, 6}}
      [s] ->
        {String.to_integer(s),{0, 6}}
    end
  end

end
