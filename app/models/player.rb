class Player < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  belongs_to :team
  belongs_to :user


  def team_size
    errors[:base] << "Three members per team maximum" if team.players.count >= 3
  end

  def calculate_opp
    shots.count == 0 ? 0 : points.to_f / shots.count.to_f
  end

  def calculate_hit_percentage
    hits = 0 
    shots.each { |s| hits += 1 unless s.cup == 0 }
    shots.count == 0 ? 0 : (hits.to_f / shots.count.to_f) * 100 
  end

  def calculate_last_cups
    hits = 0
    shots.each { |s| hits += 1 if s.cup == 10 }
    hits
  end
end
