class Shot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
  before_save :award_player
  after_destroy :punish_player

  def award_player
    if player
      player.update_attributes(:points => player.points += however_many,
                               :shot_percentage => player.shots.where("cup != 0") / player.shots,
                               :last_cups => player.last_cups += cup == 10 ? 10 : 0)

      if player.team
        player.team.update_attributes(:points => player.team.points += however_many)
      end
    end
  end

  def punish_player
    if player
      player.update_attributes(:points => player.points -= 1) if [1, 2, 3, 5, 6].include?(cup)
      player.update_attributes(:points => player.points -= 2) if [4, 7, 8, 9].include?(cup)
      player.update_attributes(:points => player.points -= 3) if cup == 10
      player.update_attributes(:shot_percentage => player.shots.where("cup != 0") / player.shots)

      if player.team
        player.team.update_attributes(:points => player.team.points -= 1) if [1, 2, 3, 5, 6].include?(cup)
        player.team.update_attributes(:points => player.team.points -= 2) if [4, 7, 8, 9].include?(cup)
        player.team.update_attributes(:points => player.team.points -= 3) if cup == 10
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
