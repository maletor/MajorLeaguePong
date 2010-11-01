class AddRoundsToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :rounds, :integer
  end

  def self.down
    remove_column :games, :rounds
  end
end
