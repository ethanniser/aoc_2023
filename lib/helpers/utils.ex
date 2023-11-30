defmodule Utils do
  def normalize_input(input) do
    input
    |> String.replace("\r\n", "\n")
    |> String.trim()
  end
end
