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
    #Player.find(player_id_change[0]).punish(self) if player_id_changed?
    #Player.find(player_id_change[1]).award(self) if player_id_changed?
  end

  def award_player
    player.award(self)
    team.award(self)
  end

  def punish_player
    player.punish(self)
    team.punish(self)
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
