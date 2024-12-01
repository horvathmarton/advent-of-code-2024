    Code.require_file("solution.exs", __DIR__)
    Code.require_file("lib.exs")

    defmodule Test do
      import Lib, only: [test: 3]

      def test_1() do
        input = """
        3   4
        4   3
        2   5
        1   3
        3   9
        3   3
        """
        expected_result = 11

        test(expected_result, Solution.solve_1(input), "day 01 / test 1")
      end

      def test_2() do
        input = ""
        expected_result = 4

        test(expected_result, Solution.solve_2(input), "day 01 / test 2")
      end
    end