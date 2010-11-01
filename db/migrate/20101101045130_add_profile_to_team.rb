class AddProfileToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :profile, :text, :null => false, :default => ""
  end

  def self.down
    remove_column :teams, :profile
  end
end
