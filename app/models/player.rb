class Player < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  belongs_to :team
  belongs_to :user
  has_many :games
  has_and_belongs_to_many :home_games, :class_name => "Game"
  has_and_belongs_to_many :away_games, :class_name => "Game"

  has_attached_file :avatar, :default_url => "/images/missing.gif", :styles => { :thumb => "230>x230" }

  validates_attachment_content_type :avatar,
    :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png'],
    :message => "only image files are allowed."

  validates_attachment_size :avatar,
    :less_than => 1.megabyte,
    :message => "max size is 1 megabyte."

  def to_param
    "#{id}-#{user.username}"
  end

  def points_per_game(game)
    points = 0
    shots.where(:game_id => game.id).each do |s|
      points += 3 if s.cup == 10
      points += 2 if [4, 7, 8, 9].include?(s.cup)
      points += 1 if [1, 2, 3, 5, 6].include?(s.cup)
    end
    points
  end

  def overall_per_game(game)
    shots.where(:game_id => game.id).count.zero? ? 0 : points_per_game(game).to_f / shots.where(:game_id => game.id).count.to_f
  end

  def calculate_hit_percentage
    hit_count.to_f / shots.count.to_f
  end

  def calculate_opp
    points.to_f / shots.count.to_f
  end

  def award(shot)
    if (1..10).include?(shot.cup)
      self.hit_count += 1
      self.points += shot.to_points
    end

    self.suicides += shot.cup - 10 if !shot.cup.nil? && shot.cup > 10
    self.opp = calculate_opp
    self.hit_percentage = calculate_hit_percentage
    save!
  end

  def punish(shot)
     if (1..10).include?(shot.cup)
      self.hit_count -= 1
      self.points -= shot.to_points
    end

    self.suicides -= shot.cup - 10 if !shot.cup.nil? && shot.cup > 10
    self.opp = calculate_opp
    self.hit_percentage = calculate_hit_percentage
    save!
  end
end
