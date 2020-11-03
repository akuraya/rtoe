defmodule Rtoe do
  # import Inflex

  # Rtoe.html "/Users/kuraya/workspace/hear_rails/sayonala-old/db/migrate/20080704074215_create_accounts.rb"

  # def html(file) do
  def html do
    # {:ok, cat} = File.read file
    {:ok, cat} = File.read "/Users/kuraya/workspace/hear_rails/sayonala-old/db/migrate/20080704074215_create_accounts.rb"

    trim_cat = String.split(cat, "\n")

    # cmd_map = %{context: "", Camel: "", lower: "", coolumns: []}


    # lower = Enum.find(trim_cat, &(String.contains?("#{&1}", "create_table"))) |> String.trim()

    lower = trim_cat
      |> Enum.find( &(String.contains?("#{&1}", "create_table")))
      |> String.trim()


    IO.inspect "lower is #{lower}"

    #TRUE:String.contains?("    create_table :accounts do |t|", "create_table")
    # Enum.find(trim_cat, &(String.contains?("    create_table :accounts do |t|", "create_table")))

    # "    create_table :accounts do |t|"
    # String.contains?(trim_cat, "create_table")

    for l <- String.split(cat, "\n") do
      line = String.trim(l)
      IO.inspect "#{line}"

      # if String.contains?(line, "create_table") do
      #   IO.inspect "containes TRUE"
      #   res = lower line
      #   IO.inspect "#{res}"
      # end
      # IO.inspect "lower is #{cmd_map[:lower]}"
    end


  end

  defp cmd_gen(cat) do
    # Context and Camel and Lower
    IO.puts "mix phx.gen.html Context Account accounts "
    asd = "Elixir rocks" |> String.upcase
  end

  # "drop_table :accounts"
  # "    create_table :accounts do |t|"
  defp lower(ll) do
    case Regex.named_captures(~r/^create_table :(?<n>.*) do |t|$/, "#{ll}") do
      nil ->
        ""
      %{"n" => ans} ->
        ans
    end
  end


  # "      t.boolean :deleted, :default => false",
  defp column(line) do

  end

  # def deps do
  #   [ { :inflex, "~> 2.0.0" } ]
  # end
end
