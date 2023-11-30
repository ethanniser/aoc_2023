defmodule Day02.Part1 do
  def solve(input) do

  end
end

defmodule Day02.Part2 do
  def solve(input) do

  end
end

defmodule Mix.Tasks.Day02 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day02/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day02.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day02.Part2.solve(input))
  end
end

