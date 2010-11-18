class Round < ActiveRecord::Base
  belongs_to :game, :counter_cache => true
  has_many :shots, :dependent => :destroy
  accepts_nested_attributes_for :shots

  after_save :punch_asshole
  before_update :determine_asshole

  def determine_asshole
    forgive_asshole
  end

  def punch_asshole
    shots_away = Shot.where("cup != 0 and round_id = ? and team_id = ?", self.id, self.game.away.id)
    shots_home = Shot.where("cup != 0 and round_id = ? and team_id = ?", self.id, self.game.home.id)

    if shots_away.count == 2
      Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", self.id, self.game.away.id).first.increment(:assholes).save!
    end
    if shots_home.count == 2
      Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", self.id, self.game.home.id).first.increment(:assholes).save!
    end
  end

  def forgive_asshole
    shots_away = Shot.where("cup != 0 and round_id = ? and team_id = ?", self.id, self.game.away.id)
    shots_home = Shot.where("cup != 0 and round_id = ? and team_id = ?", self.id, self.game.home.id)

    if shots_away.count == 2
      Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", self.id, self.game.away.id).first.decrement(:assholes).save!
    end
    if shots_home.count == 2
      Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", self.id, self.game.home.id).first.decrement(:assholes).save!
    end
  end

end
