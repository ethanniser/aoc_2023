defmodule Day08.Part1 do
  def solve(input) do
    directions =
      input
      |> String.split("\n\n")
      |> Enum.at(0)
      |> String.split("", trim: true)

    map =
      input
      |> String.split("\n\n")
      |> Enum.at(1)
      |> String.split("\n")
      |> Enum.reduce(%{}, fn line, acc ->
        [key, unparsed_value] = String.split(line, " = ")
        value = {String.slice(unparsed_value, 1..3), String.slice(unparsed_value, 6..8)}
        Map.put(acc, key, value)
      end)

    explore("AAA", directions, map, 0)
  end

  def explore("ZZZ", _directions, _map, acc), do: acc

  def explore(location, directions, map, acc) do
    value = Map.get(map, location)

    [direction | remaining_directions] = directions

    case direction do
      "R" -> explore(elem(value, 1), remaining_directions ++ [direction], map, acc + 1)
      "L" -> explore(elem(value, 0), remaining_directions ++ [direction], map, acc + 1)
    end
  end
end

defmodule Day08.Part2 do
  def solve(input) do
    directions =
      input
      |> String.split("\n\n")
      |> Enum.at(0)
      |> String.split("", trim: true)

    map =
      input
      |> String.split("\n\n")
      |> Enum.at(1)
      |> String.split("\n")
      |> Enum.reduce(%{}, fn line, acc ->
        [key, unparsed_value] = String.split(line, " = ")
        value = {String.slice(unparsed_value, 1..3), String.slice(unparsed_value, 6..8)}
        Map.put(acc, key, value)
      end)

    start_points =
      map
      |> Map.keys()
      |> Enum.filter(fn key -> String.ends_with?(key, "A") end)

    explore(start_points, directions, map, 0)
  end

  def explore(locations, directions, map, acc) do
    if all_end_with_z(locations) do
      acc
    else
      [direction | remaining_directions] = directions

      new_locations =
        locations
        |> Enum.map(fn location ->
          value = Map.get(map, location)

          case direction do
            "R" -> elem(value, 1)
            "L" -> elem(value, 0)
          end
        end)

      explore(new_locations, remaining_directions ++ [direction], map, acc + 1)
    end
  end

  def all_end_with_z(list) do
    Enum.all?(list, fn str -> String.ends_with?(str, "Z") end)
  end
end

defmodule Mix.Tasks.Day08 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day08/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day08.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day08.Part2.solve(input))
  end
end
