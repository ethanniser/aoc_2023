defmodule Day02.Part1 do
  @max_cubes %{
    red: 12,
    green: 13,
    blue: 14
  }

  @default_cubes %{
    red: 0,
    green: 0,
    blue: 0
  }

  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(": ")
      |> Enum.at(1)
      |> String.split("; ")
      |> Enum.map(fn reveal ->
        reveal
        |> String.split(", ")
        |> Enum.reduce(@default_cubes, fn num_and_color, acc ->
          cond do
            String.ends_with?(num_and_color, " blue") ->
              num = String.slice(num_and_color, 0..-6)
              %{acc | blue: String.to_integer(num)}

            String.ends_with?(num_and_color, " red") ->
              num = String.slice(num_and_color, 0..-5)
              %{acc | red: String.to_integer(num)}

            String.ends_with?(num_and_color, " green") ->
              num = String.slice(num_and_color, 0..-7)
              %{acc | green: String.to_integer(num)}
          end
        end)
      end)
      |> Enum.reduce(@default_cubes, fn reveal_map, acc ->
        %{
          blue: max(reveal_map.blue, acc.blue),
          red: max(reveal_map.red, acc.red),
          green: max(reveal_map.green, acc.green)
        }
      end)
    end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {game, _} ->
      not (game.blue > @max_cubes.blue or game.red > @max_cubes.red or
             game.green > @max_cubes.green)
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end
end

defmodule Day02.Part2 do
  @default_cubes %{
    red: 0,
    green: 0,
    blue: 0
  }

  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(": ")
      |> Enum.at(1)
      |> String.split("; ")
      |> Enum.map(fn reveal ->
        reveal
        |> String.split(", ")
        |> Enum.reduce(@default_cubes, fn num_and_color, acc ->
          cond do
            String.ends_with?(num_and_color, " blue") ->
              num = String.slice(num_and_color, 0..-6)
              %{acc | blue: String.to_integer(num)}

            String.ends_with?(num_and_color, " red") ->
              num = String.slice(num_and_color, 0..-5)
              %{acc | red: String.to_integer(num)}

            String.ends_with?(num_and_color, " green") ->
              num = String.slice(num_and_color, 0..-7)
              %{acc | green: String.to_integer(num)}
          end
        end)
      end)
      |> Enum.reduce(@default_cubes, fn reveal_map, acc ->
        %{
          blue: max(reveal_map.blue, acc.blue),
          red: max(reveal_map.red, acc.red),
          green: max(reveal_map.green, acc.green)
        }
      end)
    end)
    |> Enum.map(fn game_map ->
      game_map |> Map.values() |> Enum.product()
    end)
    |> Enum.sum()
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
