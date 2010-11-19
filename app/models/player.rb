class Player < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  belongs_to :team
  belongs_to :user

  def calculate_opp
    self.opp = self.shots.count.zero? ? 0 : self.points.to_f / self.shots.count.to_f
    save!
  end

  def calculate_points
    self.points = 0
    self.shots.each do |s|
      self.points += 3 if s.cup == 10
      self.points += 2 if [4, 7, 8, 9].include?(s.cup)
      self.points += 1 if [1, 2, 3, 5, 6].include?(s.cup)
    end
    save!
  end

  def calculate_hit_percentage
    self.hit_percentage = self.shots.count.zero? ? 0 : (self.shots.where("cup != 0").count.to_f / self.shots.count.to_f) * 100
    save!
  end

  def calculate_assholes

  end

  def team_size
    errors[:base] << "Three members per team maximum" if team.players.count > 3
  end

  def award
    calculate_points
    calculate_opp
    calculate_hit_percentage
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
