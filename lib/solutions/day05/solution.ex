defmodule Day05.Part1 do
  def solve(input) do
    chunks =
      input
      |> String.split("\n\n")

    seeds =
      chunks
      |> Enum.at(0)
      |> String.split(": ")
      |> Enum.at(1)
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    maps =
      chunks
      |> Enum.drop(1)
      |> Enum.map(fn map_str ->
        map_str
        |> String.split("\n")
        |> Enum.drop(1)
        |> Enum.map(fn row ->
          row
          |> String.split(" ")
          |> Enum.map(&String.to_integer/1)
        end)
      end)
      |> Enum.map(&parse_map/1)

    seeds
    |> Enum.map(&process_seed(&1, maps))
    |> Enum.min()
  end

  def parse_map(input) do
    input
    |> Enum.reduce(%{}, fn map_line, acc ->
      [_, src_start, len] = map_line
      Map.put(acc, src_start..(src_start + len), map_line)
    end)
  end

  def process_seed(seed, maps) do
    maps
    |> Enum.reduce(seed, fn map, acc ->
      Enum.find(map, fn {range, _} -> acc in range end)
      |> case do
        nil ->
          acc

        {_, [dest_start, src_start, _]} ->
          offset = acc - src_start
          dest_start + offset
      end
    end)
  end
end

defmodule Day05.Part2 do
  def solve(input) do
    chunks =
      input
      |> String.split("\n\n")

    seeds =
      chunks
      |> Enum.at(0)
      |> String.split(": ")
      |> Enum.at(1)
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.flat_map(fn [range_start, range_len] ->
        Enum.to_list(range_start..(range_start + range_len - 1))
      end)

    maps =
      chunks
      |> Enum.drop(1)
      |> Enum.map(fn map_str ->
        map_str
        |> String.split("\n")
        |> Enum.drop(1)
        |> Enum.map(fn row ->
          row
          |> String.split(" ")
          |> Enum.map(&String.to_integer/1)
        end)
      end)
      |> Enum.map(&parse_map/1)

    seeds
    |> Enum.map(&process_seed(&1, maps))
    |> Enum.min()
  end

  def parse_map(input) do
    input
    |> Enum.reduce(%{}, fn map_line, acc ->
      [_, src_start, len] = map_line
      Map.put(acc, src_start..(src_start + len - 1), map_line)
    end)
  end

  def process_seed(seed, maps) do
    maps
    |> Enum.reduce(seed, fn map, acc ->
      Enum.find(map, fn {range, _} -> acc in range end)
      |> case do
        nil ->
          acc

        {_, [dest_start, src_start, _]} ->
          offset = acc - src_start
          dest_start + offset
      end
    end)
  end
end

defmodule Mix.Tasks.Day05 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day05/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day05.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day05.Part2.solve(input))
  end
end
