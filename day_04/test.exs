    Code.require_file("solution.exs", __DIR__)
    Code.require_file("lib.exs")

    defmodule Test04 do
      import Lib, only: [test: 3]

      def test_1() do
        input = """
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
        """
        expected_result = 18

        test(expected_result, Solution04.solve_1(input), "day 04 / test 1")
      end

      def test_2() do
        input = """
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
        """
        expected_result = 9

        test(expected_result, Solution04.solve_2(input), "day 04 / test 2")
      end
    end
