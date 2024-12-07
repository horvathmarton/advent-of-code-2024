    Code.require_file("solution.exs", __DIR__)
    Code.require_file("lib.exs")

    defmodule Test05 do
      import Lib, only: [test: 3]

      def test_1() do
        input = """
        47|53
        97|13
        97|61
        97|47
        75|29
        61|13
        75|53
        29|13
        97|29
        53|29
        61|53
        97|53
        61|29
        47|13
        75|47
        97|75
        47|61
        75|61
        47|29
        75|13
        53|13

        75,47,61,53,29
        97,61,53,29,13
        75,29,13
        75,97,47,61,53
        61,13,29
        97,13,75,29,47
        """
        expected_result = 143

        test(expected_result, Solution05.solve_1(input), "day 05 / test 1")
      end

      def test_2() do
        input = """
        47|53
        97|13
        97|61
        97|47
        75|29
        61|13
        75|53
        29|13
        97|29
        53|29
        61|53
        97|53
        61|29
        47|13
        75|47
        97|75
        47|61
        75|61
        47|29
        75|13
        53|13

        75,47,61,53,29
        97,61,53,29,13
        75,29,13
        75,97,47,61,53
        61,13,29
        97,13,75,29,47
        """
        expected_result = 123

        test(expected_result, Solution05.solve_2(input), "day 05 / test 2")
      end
    end
