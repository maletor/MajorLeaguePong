class AddShotsCountToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :shots_count, :integer
  end

  def self.down
    remove_column :games, :shots_count
  end
end
