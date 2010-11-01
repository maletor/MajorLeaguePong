class CreateShots < ActiveRecord::Migration
  def self.up
    create_table :shots do |t|
      t.integer :round
      t.integer :player_id
      t.integer :cup

      t.timestamps
    end
  end

  def self.down
    drop_table :shots
  end
end
