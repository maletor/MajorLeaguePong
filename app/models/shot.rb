class Shot < ActiveRecord::Base
  belongs_to :player, :counter_cache => true
  belongs_to :game
  belongs_to :round
  belongs_to :team

  after_create :award_player
  before_destroy :punish_player
  before_update :process_change

  scope :hits, where("cup is not null")

  def process_change
    cup_was < cup ? award_player : punish_player
  end

  def award_player
    player.award(self)
    team.award(self)
  end

  def punish_player
    player.punish(self)
    team.punish(self)
  end

  def to_points(previous = false)
    a_cup = previous ? cup_was : cup
      
    if [1, 2, 3, 5, 6].include?(a_cup)
      1
    elsif [4, 7, 8, 9].include?(a_cup) 
      2
    elsif a_cup == 10
      3
    else
      0
    end
  end
  
  def point_change
    (to_points - to_points(true)).abs
  end
end
