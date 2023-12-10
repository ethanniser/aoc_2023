defmodule Day09.Part1 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
      |> process_list()
      |> Enum.map(fn list -> Enum.at(list, -1) end)
      |> Enum.reduce(fn n, acc -> n + acc end)
    end)
    |> Enum.sum()
  end

  def process_list(list) do
    process_list_i([list])
  end

  def process_list_i(list) do
    head = hd(list)

    if Enum.all?(head, &(&1 == 0)) do
      list
    else
      process_list_i([differences(head) | list])
    end
  end

  def differences(list) do
    list
    |> Enum.zip(Enum.drop(list, 1))
    |> Enum.map(fn {a, b} -> b - a end)
  end
end

defmodule Day09.Part2 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
      |> process_list()
      |> Enum.map(fn list -> Enum.at(list, 0) end)
      |> IO.inspect()
      |> Enum.reduce(fn n, acc -> n - acc end)
    end)
    |> Enum.sum()
  end

  def process_list(list) do
    process_list_i([list])
  end

  def process_list_i(list) do
    head = hd(list)

    if Enum.all?(head, &(&1 == 0)) do
      list
    else
      process_list_i([differences(head) | list])
    end
  end

  def differences(list) do
    list
    |> Enum.zip(Enum.drop(list, 1))
    |> Enum.map(fn {a, b} -> b - a end)
  end
end

defmodule Mix.Tasks.Day09 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day09/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day09.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day09.Part2.solve(input))
  end
end
