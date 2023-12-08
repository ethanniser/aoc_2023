defmodule Day08Test do
  use ExUnit.Case

  @example_input_1 """
                   RL

                   AAA = (BBB, CCC)
                   BBB = (DDD, EEE)
                   CCC = (ZZZ, GGG)
                   DDD = (DDD, DDD)
                   EEE = (EEE, EEE)
                   GGG = (GGG, GGG)
                   ZZZ = (ZZZ, ZZZ)
                   """
                   |> Utils.normalize_input()

  @example_input_2 """
                       LLR

                   AAA = (BBB, BBB)
                   BBB = (AAA, ZZZ)
                   ZZZ = (ZZZ, ZZZ)
                   """
                   |> Utils.normalize_input()

  @example_input_3 """
                   LR

                   11A = (11B, XXX)
                   11B = (XXX, 11Z)
                   11Z = (11B, XXX)
                   22A = (22B, XXX)
                   22B = (22C, 22C)
                   22C = (22Z, 22Z)
                   22Z = (22B, 22B)
                   XXX = (XXX, XXX)
                   """
                   |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day08.Part1.solve(@example_input_1) == 2
    assert Day08.Part1.solve(@example_input_2) == 6
  end

  test "solves example input for part 2" do
    assert Day08.Part2.solve(@example_input_3) == 6
  end
end
