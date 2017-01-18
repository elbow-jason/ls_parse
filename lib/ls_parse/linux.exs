defmodule LsParse.Linux do
  def command(path) when is_binary(path) do
    {os, ["-lah", "--time-style=full-iso", path]}
  end
end
