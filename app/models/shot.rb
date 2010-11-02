class Shot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
  before_save :increment_points
  after_destroy :decrement_points

  def increment_points
    if player
      player.update_attributes(:points => player.points += 1) if cup == 1 or cup == 2 or cup == 3 or cup == 5 or cup == 6
      player.update_attributes(:points => player.points += 2) if cup == 4 or cup == 7 or cup == 8 or cup == 9
      player.update_attributes(:points => player.points += 3) if cup == 10
      if player.team
        player.team.update_attributes(:points => player.team.points += 1) if cup == 1 or cup == 2 or cup == 3 or cup == 5 or cup == 6
        player.team.update_attributes(:points => player.team.points += 2) if cup == 4 or cup == 7 or cup == 8 or cup == 9
        player.team.update_attributes(:points => player.team.points += 3) if cup == 10
      end
    end
  end

  def decrement_points
    if player
      player.update_attributes(:points => player.points -= 1) if cup == 1 or cup == 2 or cup == 3 or cup == 5 or cup == 6
      player.update_attributes(:points => player.points -= 2) if cup == 4 or cup == 7 or cup == 8 or cup == 9
      player.update_attributes(:points => player.points -= 3) if cup == 10
      if player.team
        player.team.update_attributes(:points => player.team.points -= 1) if cup == 1 or cup == 2 or cup == 3 or cup == 5 or cup == 6
        player.team.update_attributes(:points => player.team.points -= 2) if cup == 4 or cup == 7 or cup == 8 or cup == 9
        player.team.update_attributes(:points => player.team.points -= 3) if cup == 10
      end
    end
  end
end
