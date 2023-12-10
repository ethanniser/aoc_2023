defmodule Day09Test do
  use ExUnit.Case

  @example_input """
                 0 3 6 9 12 15
                 1 3 6 10 15 21
                 10 13 16 21 30 45
                 """
                 |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day09.Part1.solve(@example_input) == 114
  end

  test "solves example input for part 2" do
    assert Day09.Part2.solve(@example_input) == 2
  end
end
