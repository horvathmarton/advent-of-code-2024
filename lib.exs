defmodule Lib do
  def test(expected_result, result, label) do
    if result != expected_result do
      IO.puts(:stderr, "Test failed for #{label}. Expected: #{expected_result} actual #{result}")

      System.halt(1)
    end

    IO.puts "Test for #{label} passed"
  end
end
