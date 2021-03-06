class Player < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  belongs_to :team
  belongs_to :user
  has_many :games
  has_and_belongs_to_many :games

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

  def award(however_many)
    points = self.points += however_many
    self.points = points
    self.opp = (points.to_f / self.shots.count.to_f)
    self.hit_percentage = self.shots.count.zero? ? 0 : self.hit_percentage = (self.shots.where("cup != 0").count.to_f / self.shots.count.to_f) * 100
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
