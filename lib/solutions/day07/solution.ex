defmodule Day07.Part1 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> then(fn [hand, bid] ->
        %{
          type: hand_type(hand),
          hand: hand_to_nums(hand),
          bid: String.to_integer(bid)
        }
      end)
    end)
    |> Enum.sort(fn hand1, hand2 ->
      cond do
        elem(hand1.type, 1) > elem(hand2.type, 1) ->
          false

        elem(hand1.type, 1) < elem(hand2.type, 1) ->
          true

        elem(hand1.type, 1) == elem(hand2.type, 1) ->
          hand1.hand < hand2.hand
      end
    end)
    |> Enum.with_index()
    |> Enum.map(fn {hand, index} ->
      hand.bid * (index + 1)
    end)
    |> Enum.sum()
  end

  def hand_to_nums(hand) do
    hand
    |> String.split("", trim: true)
    |> Enum.map(fn card ->
      case card do
        "A" -> 14
        "K" -> 13
        "Q" -> 12
        "J" -> 11
        "T" -> 10
        _ -> String.to_integer(card)
      end
    end)
  end

  def hand_type(card) do
    card
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
    |> case do
      [1, 1, 1, 1, 1] -> {:high_card, 1}
      [1, 1, 1, 2] -> {:one_pair, 2}
      [1, 2, 2] -> {:two_pairs, 3}
      [1, 1, 3] -> {:three_of_a_kind, 4}
      [2, 3] -> {:full_house, 5}
      [1, 4] -> {:four_of_a_kind, 6}
      [5] -> {:five_of_a_kind, 7}
    end
  end
end

defmodule Day07.Part2 do
  def solve(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
      |> then(fn [hand, bid] ->
        %{
          type:
            if "J" in String.split(hand, "", trim: true) do
              hand_type_joker(hand)
            else
              hand_type(hand)
            end,
          hand: hand_to_nums(hand),
          raw_hand: hand,
          bid: String.to_integer(bid)
        }
      end)
    end)
    |> Enum.sort(fn hand1, hand2 ->
      cond do
        elem(hand1.type, 1) > elem(hand2.type, 1) ->
          false

        elem(hand1.type, 1) < elem(hand2.type, 1) ->
          true

        elem(hand1.type, 1) == elem(hand2.type, 1) ->
          hand1.hand < hand2.hand
      end
    end)
    |> Enum.with_index()
    |> Enum.map(fn {hand, index} ->
      hand.bid * (index + 1)
    end)
    |> Enum.sum()
  end

  def hand_to_nums(hand) do
    hand
    |> String.split("", trim: true)
    |> Enum.map(fn card ->
      case card do
        "A" -> 13
        "K" -> 12
        "Q" -> 11
        "T" -> 10
        "J" -> 1
        _ -> String.to_integer(card)
      end
    end)
  end

  def hand_type(card) do
    card
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
    |> case do
      [1, 1, 1, 1, 1] -> {:high_card, 1}
      [1, 1, 1, 2] -> {:one_pair, 2}
      [1, 2, 2] -> {:two_pairs, 3}
      [1, 1, 3] -> {:three_of_a_kind, 4}
      [2, 3] -> {:full_house, 5}
      [1, 4] -> {:four_of_a_kind, 6}
      [5] -> {:five_of_a_kind, 7}
    end
  end

  def hand_type_joker(card) do
    n_jokers = String.split(card, "", trim: true) |> Enum.count(&(&1 == "J"))

    card
    |> String.graphemes()
    |> Enum.frequencies()
    |> Map.values()
    |> then(fn arr -> arr -- [n_jokers] end)
    |> Enum.sort(:desc)
    |> then(fn
      [head | rest] -> [head + n_jokers | rest]
      [] -> [n_jokers]
    end)
    |> Enum.sort()
    |> case do
      [1, 1, 1, 1, 1] -> {:high_card, 1}
      [1, 1, 1, 2] -> {:one_pair, 2}
      [1, 2, 2] -> {:two_pairs, 3}
      [1, 1, 3] -> {:three_of_a_kind, 4}
      [1, 3] -> {:three_of_a_kind, 4}
      [2, 3] -> {:full_house, 5}
      [1, 4] -> {:four_of_a_kind, 6}
      [5] -> {:five_of_a_kind, 7}
    end
  end
end

defmodule Mix.Tasks.Day07 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day07/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day07.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day07.Part2.solve(input))
  end
end
