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
    |> Enum.map(&parse_digits(&1, []))
    |> Enum.map(fn
      [head] -> {head, head}
      [head | rest] -> {head, List.last(rest)}
    end)
    |> Enum.map(fn {first, second} ->
      String.to_integer(first <> second)
    end)
    |> Enum.sum()
  end

  def parse_string(str) do
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

      "" ->
        nil

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

  defp parse_digits("", acc), do: Enum.reverse(acc)

  defp parse_digits(str, acc) do
    case parse_string(str) do
      {nil, rest} -> parse_digits(rest, acc)
      {digit, rest} -> parse_digits(rest, [digit | acc])
      nil -> Enum.reverse(acc)
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
