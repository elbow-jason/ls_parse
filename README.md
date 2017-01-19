# LsParse

**TODO: Add description**

## Usage

```elixir
    iex(2)> LsParse.ls("lib")
    %{files: [%LsParse{datetime: %DateTime{calendar: Calendar.ISO, day: 18, hour: 1,
         microsecond: {0, 6}, minute: 54, month: 1, second: 8, std_offset: 0,
         time_zone: "Etc/UTC", utc_offset: 0, year: 2017, zone_abbr: "UTC"},
        group: "staff", links: 4, name: ".", owner: "elbow-jason",
        perms: "drwxr-xr-x", size: 136},
       %LsParse{datetime: %DateTime{calendar: Calendar.ISO, day: 18, hour: 16,
         microsecond: {0, 6}, minute: 47, month: 1, second: 51, std_offset: 0,
         time_zone: "Etc/UTC", utc_offset: 0, year: 2017, zone_abbr: "UTC"},
        group: "staff", links: 10, name: "..", owner: "elbow-jason",
        perms: "drwxr-xr-x", size: 340},
       %LsParse{datetime: %DateTime{calendar: Calendar.ISO, day: 18, hour: 17,
         microsecond: {0, 6}, minute: 50, month: 1, second: 27, std_offset: 0,
         time_zone: "Etc/UTC", utc_offset: 0, year: 2017, zone_abbr: "UTC"},
        group: "staff", links: 7, name: "ls_parse", owner: "elbow-jason",
        perms: "drwxr-xr-x", size: 238},
       %LsParse{datetime: %DateTime{calendar: Calendar.ISO, day: 18, hour: 17,
         microsecond: {0, 6}, minute: 10, month: 1, second: 18, std_offset: 0,
         time_zone: "Etc/UTC", utc_offset: 0, year: 2017, zone_abbr: "UTC"},
        group: "staff", links: 1, name: "ls_parse.ex", owner: "elbow-jason",
        perms: "-rw-r--r--", size: 689}], total: 8}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ls_parse` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ls_parse, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ls_parse` is started before your application:

    ```elixir
    def application do
      [applications: [:ls_parse]]
    end
    ```

## TODO

  - [x] Add Tests
  - [x] Add Linux
  - [ ] Add Windows (dir?)
