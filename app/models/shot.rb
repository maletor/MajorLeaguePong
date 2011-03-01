class Shot < ActiveRecord::Base
  belongs_to :player, :counter_cache => true
  belongs_to :game
  belongs_to :round
  belongs_to :team

  after_create :award_player
  #before_destroy :punish_player
  #before_update :process_change

  def process_change
    if player_id_changed? and not cup_changed?
      Player.find(player_id_change[0]).punish(to_points)
    end
    if cup_changed? and not player_id_changed?
      player.punish(to_points)
    end
    if player_id_changed? and cup_changed?
      Player.find(player_id_change[0]).punish(to_points(cup_change[0]))
    end
  end

  def award_player
    player.award(self) unless self.cup.nil?
  end

  def punish_player
    player.punish(self) unless self.cup.nil?
  end

  def to_points
    if [1, 2, 3, 5, 6].include?(cup)
      1
    elsif [4, 7, 8, 9].include?(cup) 
      2
    elsif cup == 10
      3
    else
      0
    end
  end
end
