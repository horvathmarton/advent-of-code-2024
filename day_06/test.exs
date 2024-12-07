    Code.require_file("solution.exs", __DIR__)
    Code.require_file("lib.exs")

    defmodule Test06 do
      import Lib, only: [test: 3]

      def test_1() do
        input = """
        ....#.....
        .........#
        ..........
        ..#.......
        .......#..
        ..........
        .#..^.....
        ........#.
        #.........
        ......#...
        """
        expected_result = 41

        test(expected_result, Solution06.solve_1(input), "day 06 / test 1")
      end

      def test_2() do
        input = ""
        expected_result = 4

        test(expected_result, Solution06.solve_2(input), "day 06 / test 2")
      end
    end
