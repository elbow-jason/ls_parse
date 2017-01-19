defmodule LsParse.Linux do
  @behaviour LsParse.OS
  @os_command ~w(ls -lah --time-style=full-iso)

  def command, do: @os_command
  def command(path) when is_binary(path) do
    @os_command ++ [path]
  end

  def ls(path) when path |> is_binary do
    case path |> command |> LsParse.execute do
      {:ok, resp} ->
        parse_response(resp)
      {:error, _} = err ->
        err
    end
  end

  def parse_response(resp) when resp |> is_binary do
    {total, parts} = resp |> LsParse.Parse.parse
    %{total: total, files: Enum.map(parts, &parse_line/1)}
  end

  def parse_line([perms, links, owner, group, size, date, time, raw_offset, name]) do
    offset = parse_offset(raw_offset)
    [year, month, day] = parse_date(date)
    t = LsParse.Time.parse(time)
    dtg = %DateTime{
      year:   year,
      month:  month,
      day:    day,
      hour:   t.hour,
      minute: t.minute,
      second: t.second,
      microsecond: t.microsecond,
      time_zone: "Etc/UTC",
      utc_offset: offset,
      std_offset: offset,
      zone_abbr: "UTC",
    }
    %LsParse{
      perms:    perms,
      links:    links |> LsParse.Parse.parse_int,
      owner:    owner,
      group:    group,
      size:     size |> LsParse.Parse.parse_int,
      datetime: dtg,
      name:     name,
    }
  end

  # expected "2017-01-17"
  defp parse_date(date) do
    date
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_offset("+" <> offset) do
    LsParse.Parse.parse_int(offset)
  end

end
