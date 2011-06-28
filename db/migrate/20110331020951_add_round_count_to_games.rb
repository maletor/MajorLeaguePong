class AddRoundCountToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :rounds_count, :integer
  end

  def self.down
    remove_column :games, :rounds_count
  end
end
