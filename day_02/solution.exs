defmodule Solution do
  def solve_1(input) do
    parsed = parse_input(input)

    filtered = Enum.map(parsed, &diff_pairs/1)
      |> Enum.filter(&is_monotonous/1)
      |> Enum.filter(&has_small_steps_only/1)

    length(filtered)
  end

  def solve_2(input) do
    parse_input(input)

    "alma"
  end

  def parse_input(input) do
    String.split(input, "\n")
      |> Enum.filter(fn line -> line != "" end)
      |> Enum.map(&String.split/1)
      |> Enum.map(
        fn line -> Enum.map(
          line,
          fn num -> String.to_integer(num)
        end)
      end)
  end

  def diff_pairs(line) do
    Enum.slice(line, 1, length(line))
      |> Enum.with_index()
      |> Enum.map(fn {element, index} -> Enum.at(line, index) - element end)
  end

  def is_monotonous(line) do
    Enum.all?(line, fn item -> item > 0 end)
    || Enum.all?(line, fn item -> item < 0 end)
  end

  def has_small_steps_only(line) do
    Enum.map(line, &abs/1)
      |> Enum.all?(fn item -> 1 <= item && item <= 3 end)
  end
end
