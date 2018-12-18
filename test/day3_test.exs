defmodule Day3Test do
  use ExUnit.Case

  test "it parses input line" do
    assert Day3.parse_line("#1 @ 1,3: 4x4") == [1, 1, 3, 4, 4]
    assert Day3.parse_line("#2 @ 3,1: 4x4") == [2, 3, 1, 4, 4]
    assert Day3.parse_line("#3 @ 5,5: 2x2") == [3, 5, 5, 2, 2]
  end

  test "it marks claims for a grid" do
    map = %{
      {1, 2} => :claimed
    }

    assert Day3.mark_grid(map, {3, 2}) == %{
             {1, 2} => :claimed,
             {3, 2} => :claimed
           }

    assert Day3.mark_grid(map, {1, 2}) == %{
             {1, 2} => :overlapped
           }
  end

  test "it marks grids for a claim" do
    assert Day3.mark_claim(%{}, [1, 1, 3, 2, 2]) == %{
             {1, 3} => :claimed,
             {2, 3} => :claimed,
             {1, 4} => :claimed,
             {2, 4} => :claimed
           }

    assert %{}
           |> Day3.mark_claim([1, 1, 3, 2, 2])
           |> Day3.mark_claim([1, 1, 3, 1, 1]) == %{
             {1, 3} => :overlapped,
             {2, 3} => :claimed,
             {1, 4} => :claimed,
             {2, 4} => :claimed
           }
  end

  test "it finds overlapped claims" do
    assert [[1, 1, 3, 4, 4]] |> Day3.mark_all() |> Day3.overlapped() == 0

    assert [
             [1, 1, 3, 4, 4],
             [2, 3, 1, 4, 4],
             [3, 5, 5, 2, 2]
           ]
           |> Day3.mark_all()
           |> Day3.overlapped() == 4
  end

  test "it checks if a claim has overlaps" do
    map = %{
      {1, 3} => :claimed,
      {2, 3} => :overlapped,
      {1, 4} => :claimed,
      {2, 4} => :claimed
    }

    assert Day3.has_overlap?(map, [3, 5, 5, 2, 2]) === false
    assert Day3.has_overlap?(map, [5, 2, 3, 2, 2]) === true
  end
end
