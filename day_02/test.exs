    Code.require_file("solution.exs", __DIR__)
    Code.require_file("lib.exs")

    defmodule Test do
      import Lib, only: [test: 3]

      def test_1() do
        input = """
        7 6 4 2 1
        1 2 7 8 9
        9 7 6 2 1
        1 3 2 4 5
        8 6 4 4 1
        1 3 6 7 9
        """
        expected_result = 2

        test(expected_result, Solution.solve_1(input), "day 02 / test 1")
      end

      def test_2() do
        input = ""
        expected_result = 4

        test(expected_result, Solution.solve_2(input), "day 02 / test 2")
      end
    end
