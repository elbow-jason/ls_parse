defmodule LsParseLinuxTest do
  use ExUnit.Case
  doctest LsParse.Linux

  @example_response """
  total 1.1M
  drwxrwxr-x  7 elbow-jason staff 4.0K 2017-01-17 20:46:40.364525280 +0000 .
  drwxr-xr-x  7 elbow-jason staff 4.0K 2017-01-10 08:04:34.187400274 +0000 ..
  drwxrwxr-x  5 elbow-jason staff 4.0K 2017-01-10 08:00:51.227632772 +0000 apps
  drwxrwxr-x  4 elbow-jason staff 4.0K 2017-01-10 18:04:44.547595692 +0000 _build
  drwxrwxr-x  2 elbow-jason staff 4.0K 2017-01-10 08:00:51.227632772 +0000 config
  drwxrwxr-x 29 elbow-jason staff 4.0K 2017-01-10 08:48:45.691440649 +0000 deps
  -rw-r-----  1 elbow-jason staff 1.1M 2017-01-17 20:43:43.368500313 +0000 erl_crash.dump
  drwxrwxr-x  8 elbow-jason staff 4.0K 2017-01-17 20:54:22.824575247 +0000 .git
  -rw-rw-r--  1 elbow-jason staff  451 2017-01-17 20:43:31.828498520 +0000 .gitignore
  -rw-rw-r--  1 elbow-jason staff  607 2017-01-10 08:00:51.227632772 +0000 mix.exs
  -rw-rw-r--  1 elbow-jason staff 5.1K 2017-01-10 08:48:45.707440648 +0000 mix.lock
  -rw-rw-r--  1 elbow-jason staff   39 2017-01-10 08:00:51.223632779 +0000 README.md
  -rwxrwxr-x  1 elbow-jason staff  156 2017-01-17 20:46:39.792525201 +0000 start_debug.sh
  -rwxrwxr-x  1 elbow-jason staff  196 2017-01-10 18:09:58.843742137 +0000 start_prod.sh
  """

  setup do
    resp = LsParse.Linux.parse_response(@example_response)
    {:ok, %{
      resp: resp,
      first: resp.files |> List.first,
    }}
  end

  test "parse_response returns totals", %{resp: resp} do
    assert resp.total == 1_100_000
  end

  test "parse_response returns the correct count of files", %{resp: resp} do
    assert length(resp.files) == 14
  end

  test "parse_response returns the files in order", %{first: file} do
    assert file.name == "."
  end

  test "parse_response returns the correct fields for a file", %{first: file} do
    assert file.perms == "drwxrwxr-x"
    assert file.links == 7
    assert file.owner == "elbow-jason"
    assert file.group == "staff"
    assert file.size == 4000
    assert file.datetime.year == 2017
    assert file.datetime.month == 1
    assert file.datetime.day == 17
    assert file.datetime.hour == 20
    assert file.datetime.minute == 46
    assert file.datetime.second == 40
    assert file.datetime.microsecond == {364525, 6}
    assert file.datetime.utc_offset == 0
    assert file.name == "."
  end



end
