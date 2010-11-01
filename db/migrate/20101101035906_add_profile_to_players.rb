class AddProfileToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :profile, :text, :null => false, :default => ""
  end

  def self.down
    remove_column :players, :profile
  end
end
