class Shot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
  belongs_to :team

  before_save :award_player
  after_destroy :punish_player
  before_update :process_update

  def process_update
    if player_id_changed? and not cup_changed?
      old_player = Player.find(player_id_change[0])
      punish_player(old_player)
    end
    if cup_changed? and not player_id_changed?
      punish_player(player, however_many(cup_change[0]))
    end
    if player_id_changed? and cup_changed?

    end
  end

  def award_player(player = self.player, amount = however_many)
    if player
      player.update_attributes(
        :points => player.points += amount,
        :hit_percentage => (((player.shots.where("cup != 0")).count + (cup != 0 ? 1 : 0 )).to_f / (player.shots.count + 1).to_f) * 100,
        :opp => (player.points).to_f / (player.shots.count + 1).to_f,
        :last_cups => player.last_cups += cup == 10 ? 1 : 0)
    end

    if cup == 10
      team.update_attributes(:points => team.points += 3, :opp => team.points.to_f / (team.shots.count + 1).to_f, :wins => team.wins += 1)
      losing_team = team == game.away ? game.home : game.away
      losing_team.update_attributes(:losses => losing_team.losses += 1)
    else
      team.update_attributes(:points => team.points += amount, :opp => team.points.to_f / (team.shots.count + 1).to_f)
    end
  end

  def punish_player(player = self.player, amount = however_many)
    if player
      player.update_attributes(
        :points => player.points -= amount,
        :hit_percentage => player.shots.count > 1 ? (((player.shots.where("cup != 0")).count - (cup != 0 ? 1 : 0 )).to_f / (player.shots.count - 1).to_f) * 100 : 0,
        :opp => player.points.to_f / (player.shots.count + 1).to_f,
        :last_cups => player.last_cups -= cup == 10 ? 1 : 0)
    end

    if cup == 10
      team.update_attributes(:points => team.points -= 3, :opp => team.points.to_f / (team.shots.count + 1).to_f, :wins => team.wins -= 1)
      losing_team = team == game.away ? game.home : game.away
      losing_team.update_attributes(:losses => losing_team.losses -= 1)
    else
      team.update_attributes(:points => team.points -= amount, :opp => team.points.to_f / (team.shots.count + 1).to_f)
    end
  end

  private

  def however_many(cup = self.cup)
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
