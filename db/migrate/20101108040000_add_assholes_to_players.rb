class AddAssholesToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :assholes, :integer, :default => 0, :null => false

  end

  def self.down
    remove_column :players, :assholes
  end
end
