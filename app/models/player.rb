class Player < ActiveRecord::Base
  has_many :shots
  belongs_to :team
  belongs_to :user

  def team_size
    errors[:base] << "Three members per team maximum" if team.players.count >= 3
  end

  def hit_percentage
    hits = 0 
    shots.each do |s|
      hits += 1 unless s.cup == 0
    end

    shots.count == 0 ? 0 : (hits.to_f / shots.count.to_f) * 100 
  end

  def last_cups
    hits = 0
    shots.each do |s|
      hits += 1 if s.cup == 10
    end
    hits
  end
end
