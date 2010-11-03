class AddAssholesToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :assholes, :integer
  end

  def self.down
    remove_column :players, :assholes
  end
end
