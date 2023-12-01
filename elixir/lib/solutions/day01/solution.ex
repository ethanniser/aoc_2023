defmodule Day01.Part1 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split("")
      |> Enum.filter(&String.match?(&1, ~r/\d/))
    end)
    |> Enum.map(fn
      [head] -> {head, head}
      [head | rest] -> {head, List.last(rest)}
    end)
    |> Enum.map(fn {first, second} ->
      String.to_integer(first <> second)
    end)
    |> Enum.sum()
  end
end

defmodule Day01.Part2 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn {first, second} ->
      String.to_integer(first <> second)
    end)
    |> Enum.sum()
  end

  def parse_line(line) do
    first_digit = find_first_digit(line)
    second_digit = find_first_digit(String.reverse(line))

    {first_digit, second_digit}
  end

  def find_first_digit(str) do
    case find_first_digit_inner(str) do
      :no_match -> find_first_digit(String.slice(str, 1, String.length(str)))
      digit -> digit
    end
  end

  def find_first_digit_inner(str) do
    case str do
      "one" <> _ -> "1"
      "two" <> _ -> "2"
      "three" <> _ -> "3"
      "four" <> _ -> "4"
      "five" <> _ -> "5"
      "six" <> _ -> "6"
      "seven" <> _ -> "7"
      "eight" <> _ -> "8"
      "nine" <> _ -> "9"

      "eno" <> _ -> "1"
      "owt" <> _ -> "2"
      "eerht" <> _ -> "3"
      "ruof" <> _ -> "4"
      "evif" <> _ -> "5"
      "xis" <> _ -> "6"
      "neves" <> _ -> "7"
      "thgie" <> _ -> "8"
      "enin" <> _ -> "9"

      other ->
        first_char = String.slice(other, 0, 1)

        if String.match?(first_char, ~r/\d/) do
          first_char
        else
          :no_match
        end
    end
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
