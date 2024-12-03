defmodule TestRunner do
  def run() do
    directories =
      File.ls!(".")
      |> Enum.filter(&String.starts_with?(&1, "day_"))
      |> Enum.filter(&File.dir?(&1))
      |> Enum.sort

    run_all_tests(directories)

    run_solver_module(List.last(directories))
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
    [_, day_count] = String.split(directory, "_")
    module_name = "Test#{day_count}"

    if has_content?(input_file) do
      try do
        apply(String.to_atom("Elixir.#{module_name}"), String.to_atom("test_#{test_count}"), [])
      rescue
        error ->
          IO.puts(:stderr, "Unable to run #{module_name}.test_#{test_count}() in #{directory}")
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
    [_, day_count] = String.split(directory, "_")
    module_name = "Solution#{day_count}"

    if has_content?(input_file) do
      try do
        {:ok, input} = File.read(input_file)

        result = apply(String.to_atom("Elixir.#{module_name}"), String.to_atom("solve_#{count}"), [input])

        IO.inspect(result, label: "Solution for #{count}")
      rescue
        error ->
          IO.puts(:stderr, "Unable to run #{module_name}.solve_#{count}() in #{directory}")
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
