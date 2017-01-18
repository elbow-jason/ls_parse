defmodule LsParse.OS do
  use Behaviour

  defcallback command(String.t) :: list
  defcallback parse_line(list) :: %LsParse{} | list

end
