class AddShotsCountToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :shots_count, :integer, :default => 0, :null => false
    remove_column :games, :shots_count
    add_column :games, :shots_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :teams, :shots_count
  end
end
