defmodule Day2 do
  def letter_counts(str) do
    str
    |> split_chars()
    |> Enum.reduce(%{}, fn l, acc ->
      Map.update(acc, l, 1, &(&1 + 1))
    end)
  end

  defp split_chars(str) do
    str
    |> String.split("")
    |> Enum.reject(&(&1 == ""))
  end

  def has_same_letters?(n, map) do
    map
    |> Map.values()
    |> Enum.member?(n)
  end

  def checksum(lines) do
    {x, y} =
      lines
      |> Enum.map(&letter_counts/1)
      |> Enum.reduce({0, 0}, fn item, {m, n} ->
        {2 |> has_same_letters?(item) |> maybe_increase(m),
         3 |> has_same_letters?(item) |> maybe_increase(n)}
      end)

    x * y
  end

  def maybe_increase(true, n), do: n + 1
  def maybe_increase(_, n), do: n

  def differ_by_one?(s1, s2) do
    s1
    |> split_chars()
    |> Enum.zip(split_chars(s2))
    |> Enum.reject(fn {c1, c2} -> c1 == c2 end)
    |> length()
    |> Kernel.==(1)
  end

  def find_pair(lines), do: do_find_pair(nil, lines)
  defp do_find_pair(nil, []), do: nil
  defp do_find_pair(nil, [_]), do: nil

  defp do_find_pair(nil, [head | tail]) do
    tail
    |> Enum.reduce_while(nil, fn item, _ ->
      if differ_by_one?(head, item) do
        {:halt, [head, item]}
      else
        {:cont, nil}
      end
    end)
    |> do_find_pair(tail)
  end

  defp do_find_pair(current_result, _), do: current_result

  def extract_common(nil), do: ""

  def extract_common([s1, s2]) do
    s1
    |> split_chars()
    |> Enum.zip(split_chars(s2))
    |> Enum.filter(fn {c1, c2} -> c1 == c2 end)
    |> Enum.unzip()
    |> elem(1)
    |> Enum.join("")
  end

  def part1, do: process(&checksum/1, "day2_input.txt")

  def part2 do
    process(
      fn lines ->
        lines
        |> find_pair
        |> extract_common
      end,
      "day2_input.txt"
    )
  end

  defp process(fun, filename) do
    input_path = Path.join(:code.priv_dir(:advent), filename)

    with {:ok, inputs} <- File.read(input_path) do
      inputs
      |> String.trim()
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))
      |> fun.()
    end
  end
end
