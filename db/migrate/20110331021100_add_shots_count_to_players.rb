class AddShotsCountToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :shots_count, :integer
  end

  def self.down
    remove_column :players, :shots_count
  end
end
