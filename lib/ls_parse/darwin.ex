defmodule LsParse.Darwin do
  @behaviour LsParse.OS
  @command_opts ["-laT"]

  def ls(path) when path |> is_binary do
    case path |> command |> LsParse.execute do
      {:ok, resp} ->
        {total, parts} =
          resp
          |> LsParse.Parse.parse
        %{total: total, files: Enum.map(parts, &parse_line/1)}
      {:error, _} = err ->
        err
    end
  end

  def command(path) when is_binary(path) do
    @command_opts ++ [path]
  end

  def parse_line([perms, links, owner, group, size, month, day, time, year, name]) do
    t = LsParse.Time.parse(time)
    dtg = %DateTime{
      year:   year |> String.to_integer,
      month:  month |> month_int,
      day:    day |> String.to_integer,
      hour:   t.hour,
      minute: t.minute,
      second: t.second,
      microsecond: t.microsecond,
      time_zone: "Etc/UTC",
      utc_offset: 0,
      std_offset: 0,
      zone_abbr: "UTC",
    }
    %LsParse{
      perms:    perms,
      links:    links |> String.to_integer,
      owner:    owner,
      group:    group,
      size:     size |> String.to_integer,
      datetime: dtg,
      name:     name,
    }
  end


  @month_dict %{
    "Jan" => 1,  "Feb" => 2,  "Mar" => 3,
    "Apr" => 4,  "May" => 5,  "Jun" => 6,
    "Jul" => 7,  "Aug" => 8,  "Sep" => 9,
    "Oct" => 10, "Nov" => 11, "Dec" => 12,
  }

  defp month_int(month) do
    @month_dict[month]
  end

end
