class ModifyTeamHitCount < ActiveRecord::Migration
  def self.up
    remove_column :teams, :hit_count
    add_column :teams, :hit_count, :integer, :default => 0, :null => false
  end
end
