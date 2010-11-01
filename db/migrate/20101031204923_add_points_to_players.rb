class AddPointsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :points, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :players, :points
  end
end
