defmodule CreateDay do
  def run() do
    argv = System.argv()

    if length(argv) != 1 do
      usage()
    end

    [day_count] = argv

    directory_name = create_day_directory(day_count)
    create_files(directory_name, day_count)
  end

  def usage() do
    IO.puts(:stderr, "Usage: elixir create_day.exs <day_number>")

    System.halt(1)
  end

  def create_day_directory(day_count) do
    day_directory = "day_#{day_count}"

    case File.mkdir(day_directory) do
      :ok ->
        IO.puts "Created directory #{day_directory} successfully"
        day_directory

      {:error, :eexist} ->
        IO.puts(:stderr, "Directory #{day_directory} already exists")
        System.halt(1)

      {:error, reason} ->
        IO.puts(:stderr, "Failed to ccreate directory: #{reason}")
        System.halt(1)
    end
  end

  def create_files(directory_name, day_count) do
    files = [
      {"input_1.txt", ""},
      {"input_2.txt", ""},
      {"solution.exs", solution_template()},
      {"test.exs", test_template(day_count)},
    ]

    Enum.each(files, fn {file_name, content} ->
      path = Path.join(directory_name, file_name)
      File.write!(path, content)
      IO.puts "Created file #{path} successfully"
    end)
  end

  def solution_template() do
    """
    defmodule Solution do
      def solve_1(input) do
        parse_input(input)

        "alma"
      end

      def solve_2(input) do
        parse_input(input)

        "alma"
      end

      def parse_input(input) do
        input
      end
    end
    """
  end

  def test_template(day_count) do
    """
        Code.require_file("solution.exs", __DIR__)
        Code.require_file("lib.exs")

        defmodule Test do
          import Lib, only: [test: 3]

          def test_1() do
            input = ""
            expected_result = 4

            test(expected_result, Solution.solve_1(input), "day #{day_count} / test 1")
          end

          def test_2() do
            input = ""
            expected_result = 4

            test(expected_result, Solution.solve_2(input), "day #{day_count} / test 2")
          end
        end
    """
  end
end

CreateDay.run()
