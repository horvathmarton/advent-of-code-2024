defmodule Solution03 do
  def solve_1(input) do
    matches = get_all_occurance(input, ~r/mul\(\d{1,3},\d{1,3}\)/)

    Enum.map(matches, &parse_mul/1)
    |> Enum.sum()
  end

  def solve_2(input) do
    ignore_pattern = ~r/mul\(\d{1,3},\d{1,3}\)|don't\(\)|do\(\)/
    matches = get_all_occurance(input, ignore_pattern)

    process_matches(matches, %{ignore: false})
      |> Enum.map(&parse_mul/1)
      |> Enum.sum()
  end

  def parse_mul(match) do
    get_all_occurance(match, ~r/\d+/)
    |> Enum.map(&String.to_integer/1)
    |> Enum.product()
  end

  def get_all_occurance(string, regex) do
    Regex.scan(regex, string)
    |> List.flatten()
  end

  def process_matches([], %{ignore: _}), do: []
  def process_matches([match | rest], %{ignore: ignore}) do
    cond do
      match == "do()" -> process_matches(rest, %{ignore: false})

      match == "don't()" -> process_matches(rest, %{ignore: true})

      !ignore -> [match] ++ process_matches(rest, %{ignore: ignore})

      true -> process_matches(rest, %{ignore: ignore})
    end
  end
end
