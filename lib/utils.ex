defmodule Advent.Utils do
  def parse_lines(inputs) do
    inputs
    |> String.split("\n", trim: true)
  end

  def process(fun, filename) do
    input_path = Path.join(:code.priv_dir(:advent), filename)

    with {:ok, inputs} <- File.read(input_path) do
      inputs
      |> parse_lines()
      |> fun.()
    end
  end
end
