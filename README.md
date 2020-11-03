# Rtoe
Ruby to Elixir = Rtoe

# You can
auto generate to mix.gen.html command.

# Usage

```rtoe
#mix deps.get

iex rtoe.ex
```

```elixir
iex> Rtoe.html "~/ruby-project/db/20101010112233_create_samples.rb"

Rtoe.html "/Users/kuraya/workspace/hear_rails/sayonala-old/db/migrate/20080704074215_create_accounts.rb"

{:ok,
 "class CreateAccounts < ActiveRecord::Migration\n  def self.up\n    create_table :accounts do |t|\n      t.string :login\n      t.boolean :deleted, :default => false\n      t.string :mail, :limit => 12\n      t.string :lang, :limit => 2, :default => 'en'\n      t.timestamps\n    end\n    add_index :accounts, [:login, :deleted]\n    add_index :accounts, :mail\n  end\n\n  def self.down\n    drop_table :accounts\n  end\nend\n"}
```

1. configure migration file

Enter
