defmodule Day2Test do
  use ExUnit.Case

  test "it counts letters" do
    assert Day2.letter_counts("abc") == %{
             "a" => 1,
             "b" => 1,
             "c" => 1
           }

    assert Day2.letter_counts("bababc") == %{
             "a" => 2,
             "b" => 3,
             "c" => 1
           }
  end

  test "it checks if string has n of same letters" do
    map1 = Day2.letter_counts("abcdef")
    refute Day2.has_same_letters?(2, map1)
    map2 = Day2.letter_counts("abcccd")
    assert Day2.has_same_letters?(3, map2)
  end

  test "it only increases number with true" do
    assert Day2.maybe_increase(true, 2) == 3
    assert Day2.maybe_increase(false, 4) == 4
  end

  test "it calculates checksum" do
    inputs = ~w(
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
    )

    assert Day2.checksum(inputs) == 12
  end

  test "it checks if two strings differ by one char" do
    assert Day2.differ_by_one?("abcde", "fghij") === false
    assert Day2.differ_by_one?("fghij", "fguij") === true
  end

  test "it finds two strings that differ by one char" do
    assert Day2.find_pair([]) == nil
    assert Day2.find_pair(~w(abcde)) == nil
    assert Day2.find_pair(~w(abcde fguij klmno)) == nil
    assert Day2.find_pair(~w(fghij fguij)) == ~w(fghij fguij)
    assert Day2.find_pair(~w(
      abcde fghij klmno pqrst fguij axcye wvxyz
    )) == ~w(fghij fguij)
  end

  test "it extracts the common part from a pair" do
    assert Day2.extract_common(nil) == ""
    assert Day2.extract_common(~w(fghij fguij)) == "fgij"
  end
end
