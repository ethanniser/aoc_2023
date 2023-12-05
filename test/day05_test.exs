defmodule Day05Test do
  use ExUnit.Case

  @example_input """
                 seeds: 79 14 55 13

                 seed-to-soil map:
                 50 98 2
                 52 50 48

                 soil-to-fertilizer map:
                 0 15 37
                 37 52 2
                 39 0 15

                 fertilizer-to-water map:
                 49 53 8
                 0 11 42
                 42 0 7
                 57 7 4

                 water-to-light map:
                 88 18 7
                 18 25 70

                 light-to-temperature map:
                 45 77 23
                 81 45 19
                 68 64 13

                 temperature-to-humidity map:
                 0 69 1
                 1 0 69

                 humidity-to-location map:
                 60 56 37
                 56 93 4
                 """
                 |> Utils.normalize_input()

  test "solves example input for part 1" do
    assert Day05.Part1.solve(@example_input) == 35
  end

  test "solves example input for part 2" do
    assert Day05.Part2.solve(@example_input) == 46
  end
end
