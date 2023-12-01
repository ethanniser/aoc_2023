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

    second_digit = find_last_digit(String.reverse(line))

    case second_digit do
      nil -> {first_digit, first_digit}
      _ -> {first_digit, second_digit}
    end
  end

  def find_first_digit(str) do
    case find_first_digit_inner(str) do
      {nil, rest} -> find_first_digit(rest)
      {digit, _} -> digit
    end
  end

  def find_first_digit_inner(str) do
    case str do
      "one" <> rest ->
        {"1", rest}

      "two" <> rest ->
        {"2", rest}

      "three" <> rest ->
        {"3", rest}

      "four" <> rest ->
        {"4", rest}

      "five" <> rest ->
        {"5", rest}

      "six" <> rest ->
        {"6", rest}

      "seven" <> rest ->
        {"7", rest}

      "eight" <> rest ->
        {"8", rest}

      "nine" <> rest ->
        {"9", rest}

      other ->
        first_char = String.slice(other, 0, 1)
        rest = String.slice(other, 1, String.length(other))

        if String.match?(first_char, ~r/\d/) do
          {first_char, rest}
        else
          {nil, rest}
        end
    end
  end

  def find_last_digit(str) do
    case find_last_digit_inner(str) do
      {nil, rest} -> find_last_digit(rest)
      {digit, _} -> digit
    end
  end

  def find_last_digit_inner(str) do
    case str do
      "eno" <> rest ->
        {"1", rest}

      "owt" <> rest ->
        {"2", rest}

      "eerht" <> rest ->
        {"3", rest}

      "ruof" <> rest ->
        {"4", rest}

      "evif" <> rest ->
        {"5", rest}

      "xis" <> rest ->
        {"6", rest}

      "neves" <> rest ->
        {"7", rest}

      "thgie" <> rest ->
        {"8", rest}

      "enin" <> rest ->
        {"9", rest}

      other ->
        first_char = String.slice(other, 0, 1)
        rest = String.slice(other, 1, String.length(other))

        if String.match?(first_char, ~r/\d/) do
          {first_char, rest}
        else
          {nil, rest}
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
