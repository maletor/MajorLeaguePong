class ModifyPlayerHitCount < ActiveRecord::Migration
  def self.up
    remove_column :players, :hit_count
    add_column :players, :hit_count, :integer, :default => 0, :null => false
  end

  def self.down
    add_column :players, :hit_count
  end
end
