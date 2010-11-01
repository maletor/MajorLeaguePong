class AddRoundIdToShots < ActiveRecord::Migration
  def self.up
    remove_column :shots, :round
    add_column :shots, :round_id, :integer
  end

  def self.down
    add_column :shots, :round, :integer
    remove_column :shots, :round_id
  end
end
