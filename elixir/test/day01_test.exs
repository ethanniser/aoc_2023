defmodule Day01Test do
  use ExUnit.Case

  @example_input """

                 """
                 |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day01.Part1.solve(@example_input) == 0
  end

  test "solves example input for part 2" do
    assert Day01.Part2.solve(@example_input) == 0
  end
end
