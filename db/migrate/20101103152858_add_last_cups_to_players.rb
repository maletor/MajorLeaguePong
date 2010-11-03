class AddLastCupsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :last_cups, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :players, :last_cups
  end
end
