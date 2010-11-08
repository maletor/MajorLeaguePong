class AddCounterCache < ActiveRecord::Migration
  def self.up
    add_column :players, :shots_count, :integer, :default => 0

    Player.reset_column_information

    Player.all.each { |p| Player.reset_counters(p.id, :shots) }
  end

  def self.down
    remove_column :players, :shots_count    
  end
end
