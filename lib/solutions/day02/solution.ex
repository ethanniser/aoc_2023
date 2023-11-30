defmodule Day02.Part1 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [them, me] = String.split(line, " ")

      parsed_them =
        case them do
          "A" -> :rock
          "B" -> :paper
          "C" -> :scissors
        end

      parsed_me =
        case me do
          "X" -> :rock
          "Y" -> :paper
          "Z" -> :scissors
        end

      {parsed_me, parsed_them}
    end)
    |> Enum.map(fn game ->
      lookup_score(game)
    end)
    |> Enum.sum()
  end

  def lookup_score(game) do
    case game do
      {:rock, :rock} -> 1 + 3
      {:rock, :paper} -> 1 + 0
      {:rock, :scissors} -> 1 + 6
      {:paper, :rock} -> 2 + 6
      {:paper, :paper} -> 2 + 3
      {:paper, :scissors} -> 2 + 0
      {:scissors, :rock} -> 3 + 0
      {:scissors, :paper} -> 3 + 6
      {:scissors, :scissors} -> 3 + 3
    end
  end
end

defmodule Day02.Part2 do
  def solve(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [them, me] = String.split(line, " ")

      parsed_them =
        case them do
          "A" -> :rock
          "B" -> :paper
          "C" -> :scissors
        end

      parsed_me =
        case me do
          "X" -> :lose
          "Y" -> :draw
          "Z" -> :win
        end

      {parsed_me, parsed_them}
    end)
    |> Enum.map(fn strategy ->
      game =
        case strategy do
          {:win, :rock} -> {:paper, :rock}
          {:win, :paper} -> {:scissors, :paper}
          {:win, :scissors} -> {:rock, :scissors}
          {:draw, :rock} -> {:rock, :rock}
          {:draw, :paper} -> {:paper, :paper}
          {:draw, :scissors} -> {:scissors, :scissors}
          {:lose, :rock} -> {:scissors, :rock}
          {:lose, :paper} -> {:rock, :paper}
          {:lose, :scissors} -> {:paper, :scissors}
        end

      Day02.Part1.lookup_score(game)
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
