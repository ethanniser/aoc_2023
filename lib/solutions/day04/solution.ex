defmodule Day04.Part1 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      [winning_nums, nums] =
        line
        |> String.split(": ")
        |> Enum.at(1)
        |> String.split("|")
        |> Enum.map(&String.split(&1, " ", trim: true))

      good_nums =
        for win_num <- winning_nums,
            num <- nums,
            win_num == num,
            do: win_num

      Enum.count(good_nums)
    end)
    |> Enum.map(fn
      0 -> 0
      1 -> 1
      n -> Integer.pow(2, n - 1)
    end)
    |> Enum.sum()
  end
end

defmodule Day04.Part2 do
  def solve(input) do
    n_games =
      input
      |> String.split("\n")
      |> Enum.count()

    matches =
      input
      |> String.split("\n")
      |> Enum.map(fn line ->
        [winning_nums, nums] =
          line
          |> String.split(": ")
          |> Enum.at(1)
          |> String.split("|")
          |> Enum.map(&String.split(&1, " ", trim: true))

        good_nums =
          for win_num <- winning_nums,
              num <- nums,
              win_num == num,
              do: win_num

        Enum.count(good_nums)
      end)

    matches
    |> IO.inspect()
  end
end

defmodule Mix.Tasks.Day04 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day04/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day04.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day04.Part2.solve(input))
  end
end
