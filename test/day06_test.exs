defmodule Day06Test do
  use ExUnit.Case

  @example_input """
                 Time:      7  15   30
                 Distance:  9  40  200
                 """
                 |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day06.Part1.solve(@example_input) == 288
  end

  test "solves example input for part 2" do
    assert Day06.Part2.solve(@example_input) == 71503
  end
end
