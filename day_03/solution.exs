defmodule Solution03 do
  def solve_1(input) do
    matches = get_all_occurance(input, ~r/mul\([0-9]{1,3},[0-9]{1,3}\)/)

    Enum.map(matches, fn match -> get_all_occurance(match, ~r/[0-9]+/) end)
    |> Enum.map(fn nums -> Enum.map(nums, &String.to_integer/1) end)
    |> Enum.map(fn nums -> Enum.product(nums) end)
    |> Enum.sum
  end

  def solve_2(input) do
    input
  end

  def get_all_occurance(string, regex) do
    Regex.scan(regex, string)
      |> List.flatten()
  end

  def mul(first, second) do
    first * second
  end
end
