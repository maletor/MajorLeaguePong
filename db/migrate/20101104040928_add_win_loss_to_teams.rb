class AddWinLossToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :wins, :integer, :default => 0, :null => false
    add_column :teams, :losses, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :teams, :opp
  end
end
