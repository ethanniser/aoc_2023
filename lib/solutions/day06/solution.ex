defmodule Day06.Part1 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(":")
      |> Enum.at(1)
      |> String.split(" ", trim: true)
      |> Enum.map(fn x -> String.to_integer(x) end)
    end)
    |> Enum.zip()
    |> Enum.map(fn {time, distance} ->
      1..time
      |> Enum.map(fn x ->
        (time - x) * x
      end)
      |> Enum.filter(fn x -> x > distance end)
      |> Enum.count()
    end)
    |> Enum.product()
  end
end

defmodule Day06.Part2 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(":")
      |> Enum.at(1)
      |> String.split(" ", trim: true)
      |> Enum.join()
    end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> then(fn [time, distance] ->
      1..time
      |> Enum.map(fn x ->
        (time - x) * x
      end)
      |> Enum.filter(fn x -> x > distance end)
      |> Enum.count()
    end)
  end
end

defmodule Mix.Tasks.Day06 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day06/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day06.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day06.Part2.solve(input))
  end
end
