class AddOppToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :opp, :decimal, :precision => 8, :scale => 3, :default => 0, :null => false
  end

  def self.down
    remove_column :teams, :opp
  end
end
