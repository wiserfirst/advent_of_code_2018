defmodule Day1 do
  def parse_line("+" <> numstr) do
    String.to_integer(numstr)
  end

  def parse_line("-" <> numstr) do
    -String.to_integer(numstr)
  end

  def parse(lines) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(fn line ->
      line |> String.trim() |> parse_line()
    end)
  end

  def calc_part1(values) do
    Enum.sum(values)
  end

  def part1 do
    process(&calc_part1/1)
  end

  def calc_part2(values) do
    fn -> values end
    |> Stream.repeatedly()
    |> Stream.concat()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn value, {acc, set} ->
      new_acc = acc + value

      if MapSet.member?(set, new_acc) do
        {:halt, new_acc}
      else
        {:cont, {new_acc, MapSet.put(set, new_acc)}}
      end
    end)
  end

  def part2 do
    process(&calc_part2/1)
  end

  defp process(fun) do
    input_path = Path.join(:code.priv_dir(:advent), "day1_input.txt")

    with {:ok, inputs} <- File.read(input_path) do
      inputs |> parse() |> fun.()
    end
  end
end
