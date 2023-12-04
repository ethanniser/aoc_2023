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

    won_copies =
      matches
      |> Enum.with_index()
      |> Enum.map(fn
        {0, _} -> :no_wins
        {n, i} -> (i + 1)..(n + i) |> Enum.to_list()
      end)

    won_copies
    |> Enum.map(&(count_cards(won_copies, &1) + 1))
    |> Enum.sum()
  end

  def count_cards(_, :no_wins), do: 0

  def count_cards(won_copies, copies) do
    Enum.count(copies) +
      Enum.sum(for copy <- copies, do: count_cards(won_copies, Enum.at(won_copies, copy)))
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
