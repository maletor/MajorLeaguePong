class Team < ActiveRecord::Base
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_id'

  has_many :players
  accepts_nested_attributes_for :players

  def games
    home_games + away_games
  end

  def wins
    count = 0 
    players.each do |p|
      p.shots.each do |s|
        count += 1 if s.cup == 10
      end
    end
    count
  end

  def losses
    games.count - wins
  end

end
