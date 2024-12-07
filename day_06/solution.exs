defmodule Coord do
  defstruct [:x, :y]
end

defmodule Direction do
  def north, do: {:north, "Up"}
  def south, do: {:south, "Down"}
  def east, do: {:east, "Right"}
  def west, do: {:west, "Left"}

  def all, do: [north(), south(), east(), west()]

  def turn(dir) do
    case dir do
      {:north, _} -> east()
      {:east, _} -> south()
      {:south, _} -> west()
      {:west, _} -> north()
      _ -> raise "Invalid direction: #{inspect(dir)}"
    end
  end

  def next(%Coord{x: x, y: y} = _, dir) do
    case dir do
      {:north, _} -> %Coord{x: x, y: y - 1}
      {:east, _} -> %Coord{x: x + 1, y: y}
      {:south, _} -> %Coord{x: x, y: y + 1}
      {:west, _} -> %Coord{x: x - 1, y: y}
      _ -> raise "Invalid direction: #{inspect(dir)}"
    end
  end

  def is_out(pos, boundaries) do
    pos.x < 0 || pos.x >= boundaries.x ||
      pos.y < 0 || pos.y >= boundaries.y
  end

  def get_dimensions(map) do
    %Coord{x: length(Enum.at(map, 0)), y: length(map)}
  end
end

defmodule Solution06 do
  alias Direciton

  def solve_1(input) do
    map = parse_input(input)
    guard = find_guard(map)

    {map, _, _} = move({map, guard, Direction.north()})

    count_occurances(map, &is_used/1) + 1
  end

  def solve_2(input) do
    parse_input(input)

    "alma"
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line -> String.split(line, "", trim: true) end)
  end

  def find_guard(map) do
    Enum.with_index(map)
    |> Enum.reduce_while(nil, fn {row, row_index}, _acc ->
      case Enum.find_index(row, &is_guard/1) do
        nil -> {:cont, nil}
        col_index -> {:halt, %Coord{x: col_index, y: row_index}}
      end
    end)
  end

  def get_cell(map, pos) do
    Enum.at(Enum.at(map, pos.y), pos.x)
  end

  def set_cell(map, pos, value) do
    List.update_at(map, pos.y, fn row ->
      List.update_at(row, pos.x, fn _ -> value end)
    end)
  end

  def is_free(cell) do
    cell == "."
  end

  def is_obstacle(cell) do
    cell == "#"
  end

  def is_used(cell) do
    cell == "X"
  end

  def is_guard(cell) do
    cell == "^"
  end

  def move({map, guard_pos, guard_dir}) do
    next = Direction.next(guard_pos, guard_dir)
    dims = Direction.get_dimensions(map)

    cond do
      Direction.is_out(next, dims) ->
        {map, guard_pos, guard_dir}

      is_obstacle(get_cell(map, next)) ->
        guard_dir = Direction.turn(guard_dir)

        move({map, guard_pos, guard_dir})

      true ->
        map = set_cell(map, next, "^")
        map = set_cell(map, guard_pos, "X")

        move({map, next, guard_dir})
    end
  end

  def count_occurances(map, determinant) do
    map
    |> Enum.map(fn line -> Enum.count(line, determinant) end)
    |> Enum.sum()
  end
end
