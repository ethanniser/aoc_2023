defmodule Day03Test do
  use ExUnit.Case

  @example_input """
                 467..114..
                 ...*......
                 ..35..633.
                 ......#...
                 617*......
                 .....+.58.
                 ..592.....
                 ......755.
                 ...$.*....
                 .664.598..
                 """
                 |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day03.Part1.solve(@example_input) == 4361
  end

  test "solves example input for part 2" do
    assert Day03.Part2.solve(@example_input) == 467_835
  end
end
