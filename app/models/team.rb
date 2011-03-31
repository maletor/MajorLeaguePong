class Team < ActiveRecord::Base
  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_id'
  has_many :shots
  has_many :invitations

  has_many :players
  accepts_nested_attributes_for :players

  def to_param
    "#{id}-#{name.gsub(/ /,"-")}"
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

  def games
    home_games + away_games
  end

  def calculate_opp
    self.opp = self.shots.count.zero? ? 0 : self.points.to_f / self.shots.count.to_f
    save!
  end

  def calculate_points
    self.points = 0
    self.points += 3 * Shot.where(:team_id => self.id, :cup => 10).count
    Shot.where(:team_id => self.id).each do |s|
      self.points += 2 if [4, 7, 8, 9].include?(s.cup) 
      self.points += 1 if [1, 2, 3, 5, 6].include?(s.cup) 
    end
    save!
  end

  def calculate_wins
    count = 0 
    players.each do |p|
      p.shots.each do |s|
        count += 1 if s.cup == 10
      end
    end
    count
  end

  def calculate_losses
    games.count - wins
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
      self.wins += 1 if shot.cup == 10
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
      self.wins -= 1 if shot.cup == 10
    end

    self.suicides -= shot.cup - 10 if !shot.cup.nil? && shot.cup > 10
    self.opp = calculate_opp
    self.hit_percentage = calculate_hit_percentage
    save!
  end
end
