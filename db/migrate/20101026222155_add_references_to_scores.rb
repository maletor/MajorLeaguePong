class AddReferencesToScores < ActiveRecord::Migration
  def self.up
    add_column :scores, :player_id, :integer
  end

  def self.down
    remove_column :scores, :player_id
  end
end
