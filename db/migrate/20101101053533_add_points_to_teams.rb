class AddPointsToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :points, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :teams, :points
  end
end
