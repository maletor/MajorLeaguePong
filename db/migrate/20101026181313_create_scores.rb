class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.integer :hit_count, :null => false, :default => 0
      t.integer :point_count, :null => false, :default => 0
      t.integer :shot_count, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
