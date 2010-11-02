class AddOppToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :opp, :decimal, :precision => 8, :scale => 3
  end

  def self.down
    remove_column :players, :opp
  end
end
