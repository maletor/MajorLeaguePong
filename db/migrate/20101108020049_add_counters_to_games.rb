class AddCountersToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :rounds_count, :integer, :default => 0

    Game.reset_column_information

    Game.all.each { |g| Game.reset_counters(g.id, :rounds) }
  end

  def self.down
    remove_column :games, :rounds_count
  end
end
