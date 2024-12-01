defmodule TestRunner do
  def run() do
    directories =
      File.ls!(".")
      |> Enum.filter(&String.starts_with?(&1, "day_"))
      |> Enum.filter(&File.dir?(&1))

    run_all_tests(directories)

    last_value = Enum.sort(directories) |> List.last

    run_solver_module(last_value)
  end

  def run_all_tests(directories) do
    Enum.each(directories, fn directory ->
      test_file = Path.join(directory, "test.exs")
      check_file(test_file)

      IO.puts "Running for #{directory}"

      run_test_module(directory)
    end)
  end

  def check_file(file_name) do
    if !File.exists?(file_name) do
      IO.puts(:stderr, "#{file_name} does not exist.")

      System.halt(1)
    end
  end

  defp run_test_module(directory) do
    Code.require_file(Path.join(directory, "test.exs"))

    run_test(directory, "1")
    run_test(directory, "2")
  end

  def run_test(directory, test_count) do
    input_file = Path.join(directory, "input_#{test_count}.txt")

    if has_content?(input_file) do
      try do
        apply(String.to_atom("Elixir.Test"), String.to_atom("test_#{test_count}"), [])
      rescue
        error ->
          IO.puts(:stderr, "Unable to run Test.test_#{test_count}() in #{directory}")
          IO.inspect error
      end
    end
  end

  def run_solver_module(directory) do
    Code.require_file(Path.join(directory, "solution.exs"))

    run_solver(directory, "1")
    run_solver(directory, "2")
  end

  def run_solver(directory, count) do
    input_file = Path.join(directory, "input_#{count}.txt")

    if has_content?(input_file) do
      try do
        {:ok, input} = File.read(input_file)

        result = apply(String.to_atom("Elixir.Solution"), String.to_atom("solve_#{count}"), [input])

        IO.inspect(result, label: "Solution for #{count}")
      rescue
        error ->
          IO.puts(:stderr, "Unable to run Solver.solve_#{count}() in #{directory}")
          IO.inspect error
      end
    end
  end

  def has_content?(file_path) do
    case File.read(file_path) do
      {:ok, content} -> String.trim(content) != ""
      {:error, _reason} -> false
    end
  end
end

TestRunner.run()
