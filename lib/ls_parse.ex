defmodule LsParse do

  defstruct [
    perms:    nil,
    links:    nil,
    owner:    nil,
    group:    nil,
    size:     nil,
    datetime: nil,
    name:     nil,
  ]

  def ls(path \\ ".")
  def ls(path) when is_binary(path) do
    ls(path, module())
  end
  def ls(path, mod) when is_binary(path) do
    mod.ls(path)
  end

  def execute([cmd | cl_opts]) do
    case System.cmd(cmd, cl_opts) do
      {resp, 0} ->
        {:ok, resp}
      {resp, code} ->
        {:error, %{exit_code: code, response: resp}}
    end
  end

  def module do
    case :os.type do
      {:unix, :linux}   -> unquote(LsParse.Linux)
      {:unix, :darwin}  -> unquote(LsParse.Darwin)
    end
  end

end
