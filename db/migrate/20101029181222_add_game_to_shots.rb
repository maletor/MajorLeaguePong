class AddGameToShots < ActiveRecord::Migration
  def self.up
    add_column :shots, :game_id, :integer
  end

  def self.down
    remove_column :shots, :game_id
  end
end
