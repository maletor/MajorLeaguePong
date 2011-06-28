class ModifyTeams < ActiveRecord::Migration
  def self.up
    remove_column :teams, :hit_percentage
    add_column :teams, :hit_percentage, :decimal, :precision => 8, :scale => 3, :default => 0, :null => false
  end

  def self.down
    remove_column :teams, :hit_percentage
    add_column :teams, :hit_percentage, :decimal, :precision => 8, :scale => 3, :default => 0, :null => false
  end
end
