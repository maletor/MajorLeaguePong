class Shot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
  before_save :increment_points

  def increment_points
    if player
      player.update_attributes(:points => player.points += 1) if [1, 2, 3, 5, 6].include?(cup)
      player.update_attributes(:points => player.points += 2) if [4, 7, 8, 9].include?(cup)
      player.update_attributes(:points => player.points += 3) if cup == 10
      if player.team
        player.team.update_attributes(:points => player.team.points += 1) if [1, 2, 3, 5, 6].include?(cup)
        player.team.update_attributes(:points => player.team.points += 2) if [4, 7, 8, 9].include?(cup)
        player.team.update_attributes(:points => player.team.points += 3) if cup == 10
      end
    end
  end

  def decrement_points
    if player
      player.update_attributes(:points => player.points -= 1) if [1, 2, 3, 5, 6].include?(cup)
      player.update_attributes(:points => player.points -= 2) if [4, 7, 8, 9].include?(cup)
      player.update_attributes(:points => player.points -= 3) if cup == 10
      if player.team
        player.team.update_attributes(:points => player.team.points -= 1) if [1, 2, 3, 5, 6].include?(cup)
        player.team.update_attributes(:points => player.team.points -= 2) if [4, 7, 8, 9].include?(cup)
        player.team.update_attributes(:points => player.team.points -= 3) if cup == 10
      end
    end
  end
end
