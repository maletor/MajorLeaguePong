class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.datetime :time
      t.integer :home_id
      t.integer :away_id

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
