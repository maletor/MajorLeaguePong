class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.integer :game_id
      t.integer :number, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
