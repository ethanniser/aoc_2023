defmodule Mix.Tasks.NewDay do
  use Mix.Task

  @code_template """
  defmodule %{day_cap}.Part1 do
    def solve(input) do
      0
    end
  end
  
  defmodule %{day_cap}.Part2 do
    def solve(input) do
      0
    end
  end
  
  defmodule Mix.Tasks.%{day_cap} do
    use Mix.Task
  
    def run(_) do
      {:ok, raw_input} = File.read("lib/solutions/%{day_dir}/input.txt")
      input = raw_input |> Utils.normalize_input()
  
      IO.puts("--- Part 1 ---")
      IO.puts(%{day_cap}.Part1.solve(input))
      IO.puts("")
      IO.puts("--- Part 2 ---")
      IO.puts(%{day_cap}.Part2.solve(input))
    end
  end
  
  """

  @test_template """
  defmodule %{day_cap}Test do
    use ExUnit.Case
  
    @example_input \"\"\"
  
    \"\"\" |> Utils.normalize_input()
  
    test "solves example input for part 1" do
      assert %{day_cap}.Part1.solve(@example_input) == 0
    end
  
    test "solves example input for part 2" do
      assert %{day_cap}.Part2.solve(@example_input) == 0
    end
  end
  
  """

  def run(args) do
    case args do
      [day_str] ->
        case Integer.parse(day_str) do
          {day, ""} when day in 1..25 ->
            IO.puts("It's day #{day}! Only #{25 - day} days left until Christmas!")

            IO.puts("Creating day #{day} directory...")
            day_dir = if day > 9, do: "day#{day}", else: "day0#{day}"
            File.mkdir("lib/solutions/#{day_dir}")

            IO.puts("Creating day #{day} input file...")
            File.write("lib/solutions/#{day_dir}/input.txt", "")

            IO.puts("Creating day #{day} solution file...")

            File.write(
              "lib/solutions/#{day_dir}/solution.ex",
              @code_template
              |> String.replace("%{day_cap}", String.capitalize(day_dir))
              |> String.replace("%{day_dir}", day_dir)
            )

            IO.puts("Creating day #{day} test file...")

            File.write(
              "test/#{day_dir}_test.exs",
              @test_template
              |> String.replace("%{day_cap}", String.capitalize(day_dir))
              |> String.replace("%{day_dir}", day_dir)
            )

            IO.puts("Day #{day} created successfully!")

          _ ->
            IO.puts("Invalid day number. Please enter a number between 1 and 25.")
        end

      _ ->
        IO.puts("Please provide a day number as an argument.")
    end
  end
end
