defmodule Rtoe do
  # import Inflex

  # Rtoe.schema "migration-file-path"

  def schema(file) do
    {:ok, cat} = File.read file

    trim_cat = String.split(cat, "\n")

    lower = trim_cat
      |> Enum.find( &(String.contains?("#{&1}", "create_table")))
      |> String.trim()
      |> lower

    IO.inspect "lower is #{lower}"

    camel = trim_cat
      |> Enum.find( &(String.contains?("#{&1}", "class Create")))
      |> String.trim()
      |> camel

    IO.inspect "camel is #{camel}"

    columns = trim_cat
      |> Enum.filter( &(isColumn String.trim("#{&1}")))
      |> Enum.map(fn str -> String.trim(str) end)
      |> Enum.map(fn str -> column str end)

    IO.inspect columns
    IO.inspect "columns are #{columns}"

    "mix phx.gen.schema Context #{camel} #{lower} #{columns}"
  end

  # "    create_table :accounts do |t|"
  defp lower(ll) do
    case Regex.named_captures(~r/^create_table :(?<n>.*) do |t|$/, "#{ll}") do
      nil ->
        ""
      %{"n" => ans} ->
        ans
    end
  end

  # class CreateAccounts < ActiveRecord::Migration
  defp camel(ll) do
    case Regex.named_captures(~r/^class Create(?<n>.*)s < ActiveRecord::Migration$/, "#{ll}") do
      nil ->
        ""
      %{"n" => ans} ->
        ans
    end
  end

  # "t.string :animal"
  defp isColumn(ll) do
    case Regex.named_captures(~r/^t.*$/, "#{ll}") do
      nil ->
        false
      %{} ->
        true
    end
  end

  # "t.string :animal"
  # "t.boolean :deleted, :default => false"
  # "t.string :mail, :limit => 15"
  # "t.string :lang, :limit => 2, :default => 'en'"
  # "t.timestamps"
  defp column(str) do
    lc = String.split(str, ", ")
    [head | tail] = lc

    case Regex.named_captures(~r/^t.(?<type>.*) :(?<col>.*)$/, "#{head}") do
      nil ->
        ""
      %{"type" => type, "col" => col} ->
        "#{col}:#{type} "
    end
  end

  # def deps do
  #   [ { :inflex, "~> 2.0.0" } ]
  # end
end
