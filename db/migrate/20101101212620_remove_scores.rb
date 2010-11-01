class RemoveScores < ActiveRecord::Migration
  def self.up
    drop_table :scores
  end

  def self.down
    create_table :scores
  end
end
