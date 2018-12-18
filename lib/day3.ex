defmodule Day3 do
  def parse_line("#" <> line) do
    line
    |> String.split(["@", ",", ":", "x"])
    |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))
  end

  def mark_grid(map, position = {_, _}) do
    Map.update(map, position, :claimed, fn _ -> :overlapped end)
  end

  def all_positions([_id, x, y, w, h]) do
    for m <- x..(x + w - 1), n <- y..(y + h - 1), do: {m, n}
  end

  def mark_claim(map, claim) do
    claim
    |> all_positions()
    |> Enum.reduce(map, fn position, acc -> mark_grid(acc, position) end)
  end

  def mark_all(claims) do
    Enum.reduce(claims, %{}, &mark_claim(&2, &1))
  end

  def overlapped(map) do
    map
    |> Enum.filter(fn
      {_, :overlapped} -> true
      _ -> false
    end)
    |> Enum.count()
  end

  def find_overlapped(lines) do
    lines |> Enum.map(&parse_line/1) |> mark_all() |> overlapped()
  end

  def part1 do
    Advent.Utils.process(&find_overlapped/1, "day3_input.txt")
  end

  def has_overlap?(map, claim) do
    claim
    |> all_positions()
    |> Enum.reduce_while(false, fn position, _ ->
      if map[position] == :overlapped do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
  end

  def find_none_overlap_claim_id(lines) do
    claims = Enum.map(lines, &parse_line/1)
    map = mark_all(claims)

    claims
    |> Enum.reduce_while(nil, fn claim = [id | _], _ ->
      if has_overlap?(map, claim) do
        {:cont, nil}
      else
        {:halt, id}
      end
    end)
  end

  def part2 do
    Advent.Utils.process(&find_none_overlap_claim_id/1, "day3_input.txt")
  end
end
