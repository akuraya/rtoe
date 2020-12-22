defmodule Mix.Tasks.Schema do
  @moduledoc "Printed when the user requests `mix schema migration_file_path`"
  @shortdoc "Migration file argument"

  use Mix.Task

  @impl Mix.Task
  def run(file) do
    {:ok, contents} = File.read(file)

    lines = String.split(contents, "\n")

    table =
      lines
      |> get_table_name

    class =
      lines
      |> get_class_name

    columns =
      lines
      |> get_columns

    elements = [
      "mix phx.gen.schema Context.#{class}",
      "context_#{table}",
      columns
    ]

    Mix.shell().info(Enum.join(elements, " "))
  end

  defp get_table_name(lines) do
    line =
      lines
      |> line_containing_word("create_table")

    case Regex.named_captures(~r/^create_table :(?<tn>.*) do |t|$/, "#{line}") do
      nil ->
        ""

      %{"tn" => table_name} ->
        table_name
    end
  end

  defp get_class_name(lines) do
    line =
      lines
      |> line_containing_word("class Create")

    case Regex.named_captures(~r/^class Create(?<cn>.*)s < ActiveRecord::Migration$/, "#{line}") do
      nil ->
        ""

      %{"cn" => class_name} ->
        class_name
    end
  end

  defp get_columns(lines) do
    lines
    |> Enum.filter(&is_column(String.trim("#{&1}")))
    |> Enum.map(fn str -> String.trim(str) end)
    |> Enum.map(fn str -> get_column_type(str) end)
  end

  defp get_column_type(str) do
    lc = String.split(str, ", ")
    [head | _] = lc

    case Regex.named_captures(~r/^t.(?<type>.*) :(?<col>.*)$/, "#{head}") do
      nil ->
        ""

      %{"type" => type, "col" => col} ->
        "#{col}:#{type} "
    end
  end

  defp is_column(line) do
    case Regex.named_captures(~r/^t.*$/, "#{line}") do
      nil ->
        false

      %{} ->
        true
    end
  end

  def line_containing_word(lines, word) do
    lines
    |> Enum.find(&String.contains?("#{&1}", word))
    |> String.trim()
  end
end
