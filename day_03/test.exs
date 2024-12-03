    Code.require_file("solution.exs", __DIR__)
    Code.require_file("lib.exs")

    defmodule Test03 do
      import Lib, only: [test: 3]

      def test_1() do
        input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
        expected_result = 161

        test(expected_result, Solution03.solve_1(input), "day 03 / test 1")
      end

      def test_2() do
        input = ""
        expected_result = 4

        test(expected_result, Solution03.solve_2(input), "day 03 / test 2")
      end
    end
