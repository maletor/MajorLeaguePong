class AddSuicidesToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :suicides, :integer, :default => 0
  end

  def self.down
    remove_column :players, :suicides
  end
end
