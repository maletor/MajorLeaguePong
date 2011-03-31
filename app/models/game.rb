class Game < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  has_many :rounds, :order => 'number', :dependent => :destroy
  accepts_nested_attributes_for :shots
  belongs_to :away, :class_name => 'Team'
  belongs_to :home, :class_name => 'Team'

  has_and_belongs_to_many :home_players, :class_name => 'Player', :association_foreign_key => "home_player_id"
  has_and_belongs_to_many :away_players, :class_name => 'Player', :association_foreign_key => "away_player_id"
  
  accepts_nested_attributes_for :rounds, :allow_destroy => true

  def to_param
    "#{id}-#{away.name}-#{home.name.gsub(/ /,"-")}"
  end

  def players
    away_players + home_players 
  end
end
