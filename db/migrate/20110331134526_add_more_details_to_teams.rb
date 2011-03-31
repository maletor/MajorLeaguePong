class AddMoreDetailsToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :suicides, :integer, :default => 0, :null => false
    add_column :teams, :assholes, :integer, :default => 0, :null => false
    add_column :teams, :hit_percentage, :decimal, :default => 0, :null => false
  end

  def self.down
    remove_column :teams, :suicides
    remove_column :teams, :assholes
    remove_column :teams, :hit_percentage
  end
end
