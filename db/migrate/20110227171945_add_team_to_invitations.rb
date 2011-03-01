class AddTeamToInvitations < ActiveRecord::Migration
  def self.up
    add_column :invitations, :team_id, :integer
  end

  def self.down
    remove_column :invitations, :team_id
  end
end
