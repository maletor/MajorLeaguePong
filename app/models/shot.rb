class Shot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
  belongs_to :team

  before_save :award_player
  after_destroy :punish_player

  def award_player
    if player
      player.update_attributes(
        :points => player.points += however_many,
        :hit_percentage => (((player.shots.where("cup != 0")).count + (cup != 0 ? 1 : 0 )).to_f / (player.shots.count + 1).to_f) * 100,
        :opp => (player.points).to_f / (player.shots.count + 1).to_f,
        :last_cups => player.last_cups += cup == 10 ? 1 : 0)

        if cup == 10
          team.update_attributes(:points => team.points += 3, :opp => team.points.to_f / (team.shots.count + 1).to_f, :wins => team.wins += 1)
          losing_team = team == game.away ? game.home : game.away
          losing_team.update_attributes(:losses => losing_team.losses += 1)
        else
          team.update_attributes(:points => team.points += however_many, :opp => team.points.to_f / (team.shots.count + 1).to_f)
        end

    end
  end

  def punish_player
    if player
      player.update_attributes(
        :points => player.points -= however_many,
        :opp => player.calculate_opp,
        :hit_percentage => player.calculate_hit_percentage,
        :last_cups => player.last_cups -= cup == 10 ? 1 : 0)

        if cup == 10
          team.update_attributes(:points => team.points -= 3, :opp => team.points.to_f / (team.shots.count + 1).to_f, :wins => team.wins -= 1)
          losing_team = team == game.away ? game.home : game.away
          losing_team.update_attributes(:losses => losing_team.losses -= 1)
        else
          team.update_attributes(:points => team.points -= however_many, :opp => team.points.to_f / (team.shots.count + 1).to_f)
        end
    end
  end

  private

  def however_many
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
