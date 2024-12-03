defmodule Solution02 do
  def solve_1(input) do

  end

  def solve_2(input) do

  end

  def parse_input(input) do
    String.split(input, "\n")
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
  end

  def diff_pairs(line) do
    Enum.slice(line, 1, length(line))
    |> Enum.with_index()
    |> Enum.map(fn {element, index} -> Enum.at(line, index) - element end)
  end

  def is_monotonous(line) do
    Enum.all?(line, fn item -> item > 0 end) ||
      Enum.all?(line, fn item -> item < 0 end)
  end

  def has_small_steps_only(line) do
    Enum.map(line, &abs/1)
    |> Enum.all?(fn item -> 1 <= item && item <= 3 end)
  end

  def is_safe(line) do
    is_monotonous(line) && has_small_steps_only(line)
  end

  def generate_tolerated_series(line) do
    Enum.to_list(0..(length(line) - 1))
    |> Enum.map(fn index ->
      Enum.reject(Enum.with_index(line), fn {_, i} -> i == index end)
      |> Enum.map(fn {element, _} -> element end)
    end)
  end
end
