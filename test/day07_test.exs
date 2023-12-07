defmodule Day07Test do
  use ExUnit.Case

  @example_input """
                 32T3K 765
                 T55J5 684
                 KK677 28
                 KTJJT 220
                 QQQJA 483
                 """
                 |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day07.Part1.solve(@example_input) == 6440
  end

  test "solves example input for part 2" do
    assert Day07.Part2.solve(@example_input) == 5905
  end
end
