defmodule Day03.Part1 do
  def solve(input) do
    grid =
      input
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "", trim: true))

    cords =
      grid
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, y} ->
        row
        |> Enum.with_index()
        |> Enum.flat_map(fn {cell, x} ->
          cond do
            String.match?(cell, ~r/[0-9.]/) ->
              []

            true ->
              find_number_neighbours(grid, {x, y})
              |> Enum.map(&find_start_of_number(grid, &1))
          end
        end)
      end)
      |> Enum.uniq()

    Enum.map(cords, fn {x, y} ->
      grid |> Enum.at(y) |> Enum.drop(x) |> Enum.take_while(&String.match?(&1, ~r/\d/))
    end)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  def find_start_of_number(grid, {x, y}) do
    row = grid |> Enum.at(y)

    num_length =
      row
      |> Enum.reverse()
      |> Enum.drop(Enum.count(row) - x)
      |> Enum.take_while(&String.match?(&1, ~r/\d/))
      |> Enum.count()

    {x - num_length, y}
  end

  def find_number_neighbours(grid, {x, y}) do
    get_adjacent_cells(grid, {x, y})
    |> Enum.filter(fn {_, _, cell} -> String.match?(cell, ~r/\d/) end)
    |> Enum.map(fn {adj_x, adj_y, _} -> {adj_x, adj_y} end)
  end

  def get_adjacent_cells(grid, {x, y}) do
    adjacency_offsets()
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.filter(fn {adj_x, adj_y} -> is_within_grid(grid, adj_x, adj_y) end)
    |> Enum.map(fn {adj_x, adj_y} -> {adj_x, adj_y, get_cell_value(grid, adj_x, adj_y)} end)
  end

  def adjacency_offsets do
    for dx <- -1..1, dy <- -1..1, dx != 0 or dy != 0, do: {dx, dy}
  end

  def is_within_grid(grid, x, y) do
    x >= 0 and x < Enum.count(grid) and y >= 0 and y < Enum.count(List.first(grid))
  end

  def get_cell_value(grid, x, y) do
    grid |> Enum.at(y) |> Enum.at(x)
  end
end

defmodule Day03.Part2 do
  def solve(input) do
    grid =
      input
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "", trim: true))

    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, x} ->
        cond do
          cell != "*" ->
            []

          true ->
            nums =
              find_number_neighbours(grid, {x, y})
              |> Enum.map(&find_start_of_number(grid, &1))
              |> Enum.uniq()

            if Enum.count(nums) == 2 do
              nums
            else
              []
            end
        end
      end)
      |> Enum.filter(&(&1 != []))
    end)
    |> Enum.filter(&(&1 != []))
    |> Enum.flat_map(fn pairs ->
      pairs
      |> Enum.map(fn [cords1, cords2] ->
        get_int_from_first_cord(grid, cords1) * get_int_from_first_cord(grid, cords2)
      end)
    end)
    |> Enum.sum()
  end

  def get_int_from_first_cord(grid, {x, y}) do
    grid
    |> Enum.at(y)
    |> Enum.drop(x)
    |> Enum.take_while(&String.match?(&1, ~r/\d/))
    |> Enum.join()
    |> String.to_integer()
  end

  def find_start_of_number(grid, {x, y}) do
    row = grid |> Enum.at(y)

    num_length =
      row
      |> Enum.reverse()
      |> Enum.drop(Enum.count(row) - x)
      |> Enum.take_while(&String.match?(&1, ~r/\d/))
      |> Enum.count()

    {x - num_length, y}
  end

  def find_number_neighbours(grid, {x, y}) do
    get_adjacent_cells(grid, {x, y})
    |> Enum.filter(fn {_, _, cell} -> String.match?(cell, ~r/\d/) end)
    |> Enum.map(fn {adj_x, adj_y, _} -> {adj_x, adj_y} end)
  end

  def get_adjacent_cells(grid, {x, y}) do
    adjacency_offsets()
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.filter(fn {adj_x, adj_y} -> is_within_grid(grid, adj_x, adj_y) end)
    |> Enum.map(fn {adj_x, adj_y} -> {adj_x, adj_y, get_cell_value(grid, adj_x, adj_y)} end)
  end

  def adjacency_offsets do
    for dx <- -1..1, dy <- -1..1, dx != 0 or dy != 0, do: {dx, dy}
  end

  def is_within_grid(grid, x, y) do
    x >= 0 and x < Enum.count(grid) and y >= 0 and y < Enum.count(List.first(grid))
  end

  def get_cell_value(grid, x, y) do
    grid |> Enum.at(y) |> Enum.at(x)
  end
end

defmodule Mix.Tasks.Day03 do
  use Mix.Task

  def run(_) do
    {:ok, raw_input} = File.read("lib/solutions/day03/input.txt")
    input = raw_input |> Utils.normalize_input()

    IO.puts("--- Part 1 ---")
    IO.puts(Day03.Part1.solve(input))
    IO.puts("")
    IO.puts("--- Part 2 ---")
    IO.puts(Day03.Part2.solve(input))
  end
end
