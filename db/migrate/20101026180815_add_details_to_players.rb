class AddDetailsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :hit_count, :integer
    add_column :players, :shot_count, :integer
    add_column :players, :point_count, :integer
  end

  def self.down
    remove_column :players, :point_count
    remove_column :players, :shot_count
    remove_column :players, :hit_count
  end
end
