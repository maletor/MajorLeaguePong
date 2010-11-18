class Shot < ActiveRecord::Base
  belongs_to :player, :counter_cache => true
  belongs_to :game
  belongs_to :round
  belongs_to :team

  after_save :award_player
  before_destroy :punish_player
  before_update :process_update

  def process_update
    if player_id_changed? and not cup_changed?
      Player.find(player_id_change[0]).punish(however_many)
    end
    if cup_changed? and not player_id_changed?
      player.punish(however_many)
    end
    if player_id_changed? and cup_changed?
      Player.find(player_id_change[0]).punish(however_many(cup_change[0]))
    end
  end

  def award_player
    if player
      player.award(however_many)
    end

    if cup == 10
      team.update_attributes(:points => team.points += 3, :opp => team.points.to_f / (team.shots.count + 1).to_f, :wins => team.wins += 1)
      losing_team = team == game.away ? game.home : game.away
      losing_team.update_attributes(:losses => losing_team.losses += 1)
    else
      team.update_attributes(:points => team.points += however_many, :opp => team.points.to_f / (team.shots.count + 1).to_f)
    end
  end

  def punish_player
    player.punish(however_many) if player

    if cup == 10
      team.update_attributes(:points => team.points -= 3, :opp => team.points.to_f / (team.shots.count + 1).to_f, :wins => team.wins -= 1)
      losing_team = team == game.away ? game.home : game.away
      losing_team.update_attributes(:losses => losing_team.losses -= 1)
    else
      team.update_attributes(:points => team.points -= however_many, :opp => team.points.to_f / (team.shots.count + 1).to_f)
    end
  end

  private



  def however_many(cup = cup)
    if [1, 2, 3, 5, 6].include?(cup)
      1
    elsif [4, 7, 8, 9].include?(cup) 
      2
    elsif cup == 10
      3
    else
      0
    end
  end

end
