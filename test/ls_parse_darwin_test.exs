defmodule LsParseDarwinTest do
  use ExUnit.Case
  doctest LsParse.Darwin

  @example_response """
  total 16
  -rw-r--r--  1 elbow-jason  staff  495 Jan 18 16:57:38 2017 README.md
  drwxr-xr-x  3 elbow-jason  staff  102 Jan 17 23:45:29 2017 _build
  drwxr-xr-x  3 elbow-jason  staff  102 Jan 17 22:32:44 2017 config
  drwxr-xr-x  4 elbow-jason  staff  136 Jan 18 01:54:08 2017 lib
  -rw-r--r--  1 elbow-jason  staff  670 Jan 17 22:32:44 2017 mix.exs
  drwxr-xr-x  4 elbow-jason  staff  136 Jan 17 22:32:44 2017 test
  """

  setup do
    resp = LsParse.Darwin.parse_response(@example_response)
    {:ok, %{
      resp: resp,
      first: resp.files |> List.first,
    }}
  end

  test "parse_response returns totals", %{resp: resp} do
    assert resp.total == 16
  end

  test "parse_response returns the correct count of files", %{resp: resp} do
    assert length(resp.files) == 6
  end

  test "parse_response returns the files in order", %{first: file} do
    assert file.name == "README.md"
  end

  test "parse_response returns the correct fields for a file", %{first: file} do
    assert file.perms == "-rw-r--r--"
    assert file.links == 1
    assert file.owner == "elbow-jason"
    assert file.group == "staff"
    assert file.size == 495
    assert file.datetime.year == 2017
    assert file.datetime.month == 1
    assert file.datetime.day == 18
    assert file.datetime.hour == 16
    assert file.datetime.minute == 57
    assert file.datetime.second == 38
    assert file.datetime.microsecond == {0, 6}
    assert file.datetime.utc_offset == 0
    assert file.name == "README.md"
  end
end
