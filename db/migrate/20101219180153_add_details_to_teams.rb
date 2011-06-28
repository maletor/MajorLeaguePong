class AddDetailsToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :hit_count, :integer
    add_column :teams, :shot_count, :integer
  end

  def self.down
    remove_column :teams, :shot_count
    remove_column :teams, :hit_count
  end
end
