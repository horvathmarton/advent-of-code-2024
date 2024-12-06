defmodule Coord do
  defstruct [:x, :y]
end

defmodule Solution04 do
  def solve_1(input) do
    matrix = parse_input(input)
    dimensions = get_dimensions(matrix)

    find_occurances(matrix, "X")
    |> Enum.map(&Enum.map(get_surrounding_coords(&1, dimensions), fn next -> {&1, next} end))
    |> List.flatten()
    |> Enum.map(fn {curr, next} -> does_match(matrix, %{prev: curr, curr: next, text: "MAS"}) end)
    |> Enum.count(& &1)
  end

  def solve_2(input) do
    parse_input(input)

    "alma"
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn x -> String.split(x, "", trim: true) end)
  end

  def find_occurances(matrix, char) do
    Enum.with_index(matrix)
    |> Enum.map(fn {line, y} ->
      Enum.with_index(line) |> Enum.map(fn {char, x} -> {char, %Coord{x: x, y: y}} end)
    end)
    |> List.flatten()
    |> Enum.filter(fn {c, _} -> c == char end)
    |> Enum.map(fn {_, coord} -> coord end)
  end

  def is_valid_coord(coord, dimensions) do
    coord.x >= 0 && coord.x < dimensions.x &&
      coord.y >= 0 && coord.y < dimensions.y
  end

  def get_surrounding_coords(curr, dimensions) do
    offset_matrix = for x <- -1..1, y <- -1..1, do: {x, y}

    Enum.map(offset_matrix, fn {x, y} -> %Coord{x: curr.x + x, y: curr.y + y} end)
    |> Enum.reject(fn coord -> coord == curr end)
    |> Enum.filter(fn coord -> is_valid_coord(coord, dimensions) end)
  end

  def get_next_coord(prev, curr, dimensions) do
    next = %Coord{
      x: curr.x + (curr.x - prev.x),
      y: curr.y + (curr.y - prev.y)
    }

    cond do
      is_valid_coord(next, dimensions) -> next
      true -> nil
    end
  end

  def does_match(matrix, %{prev: prev, curr: curr, text: text}) do
    dimensions = get_dimensions(matrix)
    [char | rest] = String.split(text, "", trim: true)

    actual = Enum.at(Enum.at(matrix, curr.y), curr.x)
    next = get_next_coord(prev, curr, dimensions)

    cond do
      length(rest) == 0 && char == actual -> true
      actual != char -> false
      is_nil(next) -> false
      true -> does_match(matrix, %{prev: curr, curr: next, text: Enum.join(rest, "")})
    end
  end

  def get_dimensions(matrix) do
    %Coord{x: length(Enum.at(matrix, 0)), y: length(matrix)}
  end
end
