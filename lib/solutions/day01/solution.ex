defmodule Day01.Part1 do
  def solve(input) do
    0
  end
end

defmodule Day01.Part2 do
  def solve(input) do
    0
  end
end

defmodule Mix.Tasks.Day01 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day01/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day01.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day01.Part2.solve(input))
  end
end
