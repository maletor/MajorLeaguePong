class Player < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  belongs_to :team
  belongs_to :user

  def team_size
    errors[:base] << "Three members per team maximum" if team.players.count > 3
  end

  def award(however_many)
    points = self.points += however_many
    self.points = points
    self.opp = (points.to_f / self.shots.count.to_f)
    self.hit_percentage = (self.shots.where("cup != 0").count.to_f / self.shots.count.to_f) * 100
    save!
  end
  
  def punish(however_many)
    points = self.points -= however_many
    self.points = points
    self.opp = (points.to_f / self.shots.count.to_f)
    self.hit_percentage = self.shots.count == 0 ? self.hit_percentage = (self.shots.where("cup != 0").count.to_f / self.shots.count.to_f) * 100 : 0
    save!
  end

end
