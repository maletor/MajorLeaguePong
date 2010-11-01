class RemoveRoundsFromGames < ActiveRecord::Migration
  def self.up
    remove_column :games, :rounds
  end

  def self.down
    add_column :games, :rounds, :integer
  end
end
