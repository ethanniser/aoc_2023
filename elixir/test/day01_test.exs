defmodule Day01Test do
  use ExUnit.Case

  @example_input """
                 1abc2
                 pqr3stu8vwx
                 a1b2c3d4e5f
                 treb7uchet
                 """
                 |> Utils.normalize_input()

  @part2_example_input """
                       two1nine
                       eightwothree
                       abcone2threexyz
                       xtwone3four
                       4nineeightseven2
                       zoneight234
                       7pqrstsixteen
                       """
                       |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day01.Part1.solve(@example_input) == 142
  end

  test "solves example input for part 2" do
    assert Day01.Part2.solve(@part2_example_input) == 281
  end
end
