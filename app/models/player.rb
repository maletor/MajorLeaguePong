class Player < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  belongs_to :team
  belongs_to :user
  has_many :games
  has_and_belongs_to_many :home_games, :class_name => "Game"
  has_and_belongs_to_many :away_games, :class_name => "Game"

  has_attached_file :avatar, :default_url => "/images/missing.gif", :styles => { :thumb => "230x230>" }, :storage => :s3

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
    self.shots.where(:game_id => game.id).each do |s|
      points += 3 if s.cup == 10
      points += 2 if [4, 7, 8, 9].include?(s.cup)
      points += 1 if [1, 2, 3, 5, 6].include?(s.cup)
    end
    points
  end

  def overall_per_game(game)
    self.shots.where(:game_id => game.id).count.zero? ? 0 : points_per_game(game).to_f / self.shots.where(:game_id => game.id).count.to_f
  end

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
    if self.team
      self.team.away_games.each do |ag|
        ag.rounds.each do |r|
          away_shots = 0
          away_shots += 1 if Shot.where("cup != 0 and round_id = ? and team_id = ?", r.id, ag.away.id).count == 2

          Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", r.id, ag.away.id).first.increment!(:assholes) if away_shots == 1 and not Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", r.id, ag.away.id).first.blank?
        end
      end

      self.team.home_games.each do |hg|
        hg.rounds.each do |r|
          home_shots = 0
          home_shots += 1 if Shot.where("cup != 0 and round_id = ? and team_id = ?", r.id, hg.home.id).count == 2

          Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", r.id, hg.home.id).first.increment!(:assholes) if home_shots == 1 and not Player.includes(:shots).where("shots.cup == 0 and shots.round_id = ? and shots.team_id = ?", r.id, hg.home.id).first.blank?
        end
      end
    end
  end

  def team_size
    errors[:base] << "Three members per team maximum" if team.players.count > 3
  end

  def award(shot)
    unless shot.cup == 11
      self.hit_count += 1 unless shot.cup.zero?
      self.points += shot.to_points
      self.opp = points.to_f / self.shots.where(:cup => 0..10).count.to_f
      self.hit_percentage = hit_count.to_f / self.shots.where(:cup => 0..10).count.to_f
    else
      self.suicides += 1
    end
    save!
  end

  def punish(shot)
    unless shot.cup == 11
      player_points = points - shot.to_points
      self.points = player_points
      self.opp = (player_points.to_f / self.shots.count.to_f)
    else
      self.suicides -= 1
    end
    save!
  end

end
