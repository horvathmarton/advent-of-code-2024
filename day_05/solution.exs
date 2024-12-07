defmodule Rule do
  defstruct [:from, :to]
end

defmodule Solution05 do
  def solve_1(input) do
    {rules, updates} = parse_input(input)

    Enum.filter(updates, fn update -> does_follow_ruleset(update, rules) end)
    |> Enum.map(&transform_back_to_list/1)
    |> Enum.map(&get_middle_value/1)
    |> Enum.map(fn {value, _} -> String.to_integer(value) end)
    |> Enum.sum()
  end

  def solve_2(input) do
    {rules, updates} = parse_input(input)

    Enum.filter(updates, fn update -> !does_follow_ruleset(update, rules) end)
    |> Enum.map(&transform_back_to_list/1)
    |> Enum.map(fn update -> sort(update, rules) end)
    |> Enum.map(&get_middle_value/1)
    |> Enum.map(fn {value, _} -> String.to_integer(value) end)
    |> Enum.sum()
  end

  def parse_input(input) do
    lines = String.split(input, "\n")

    rules =
      Enum.filter(lines, fn line -> String.contains?(line, "|") end)
      |> Enum.map(fn line ->
        [from, to] = String.split(line, "|", trim: true)

        %Rule{from: from, to: to}
      end)

    updates =
      Enum.filter(lines, fn line -> String.contains?(line, ",") end)
      |> Enum.map(fn line ->
        String.split(line, ",", trim: true)
        |> Enum.with_index()
        |> Enum.into(%{})
      end)

    {rules, updates}
  end

  def does_follow_ruleset(update, rules) do
    Enum.all?(rules, fn rule -> does_follow_rule(update, rule) end)
  end

  def does_follow_rule(update, rule) do
    from = Map.get(update, rule.from, nil)
    to = Map.get(update, rule.to, nil)

    if Enum.any?([from, to], &is_nil/1) do
      true
    else
      to - from > 0
    end
  end

  def transform_back_to_list(map) do
    Map.to_list(map)
    |> Enum.sort_by(fn {_key, value} -> value end)
  end

  def get_middle_value(list) do
    middle_index = div(length(list), 2)

    Enum.at(list, middle_index)
  end

  def sort_pair(a, b, rules) do
    matching_rule = Enum.find(rules, fn rule -> (a == rule.from || b == rule.from) && (a == rule.to || b == rule.to) end)

    if (matching_rule) do
      matching_rule.from == b && matching_rule.to == a
    else
      false
    end
  end

  def sort(list, rules) do
    Enum.sort(list, fn a, b -> sort_pair(elem(a, 0), elem(b, 0), rules) end)
  end
end
