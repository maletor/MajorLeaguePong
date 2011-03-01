class CreateGamesPlayersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :games_players, :id => false do |t|
      t.integer :game_id
      t.integer :home_player_id
      t.integer :away_player_id
    end

  end

  def self.down
    drop_table :games_players
  end
end
