defmodule Solution do
  def solve_1(input) do
    { left, right } = parse_input(input)

    diffs = Enum.zip(Enum.sort(left), Enum.sort(right))
      |> Enum.map(fn {left, right} -> abs(left - right) end)

    Enum.sum(diffs)
  end

  def solve_2(input) do
    parse_input(input)

    "alma"
  end

  def parse_input(input) do
    lines = String.split(input, "\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(fn line -> line != "" end)

    left_col = Enum.map(lines, fn line ->
        [left, _] = String.split(line) |> Enum.map(&String.to_integer/1)

        left
      end)

    right_col = Enum.map(lines, fn line ->
      [_, right] = String.split(line) |> Enum.map(&String.to_integer/1)

      right
    end)

    { left_col, right_col }
  end
end
