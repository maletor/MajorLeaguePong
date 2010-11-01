class Player < ActiveRecord::Base
  has_one :score
  has_many :shots
  belongs_to :team
  belongs_to :user

  def points
    points = 0
    shots.each do |s|
      points += 1 if s.cup == 1 or s.cup == 2 or s.cup == 3
      points += 2 if s.cup == 4 or s.cup == 5 or s.cup == 6
      points += 3 if s.cup == 7 or s.cup == 8
      points += 5 if s.cup == 9
      points += 7 if s.cup == 10
    end
    points
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
