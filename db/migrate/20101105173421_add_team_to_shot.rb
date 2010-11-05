class AddTeamToShot < ActiveRecord::Migration
  def self.up
    add_column :shots, :team_id, :integer
  end

  def self.down
    remove_column :shots, :team_id
  end
end
