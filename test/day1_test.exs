defmodule Day1Test do
  use ExUnit.Case

  test "it parses a line" do
    assert Day1.parse_line("+1") == 1
    assert Day1.parse_line("-2") == -2
  end

  test "it parses multiple lines" do
    input = """
    +1
    -2
    +3
    +1
    """

    assert Day1.parse(input) == [1, -2, 3, 1]
  end

  test "it accumulates inputs" do
    assert Day1.calc_part1([1, -2, 3, 1]) == 3
  end

  test "it finds first repeated frequency" do
    assert Day1.calc_part2([1, -2, 3, 1]) == 2
  end
end
