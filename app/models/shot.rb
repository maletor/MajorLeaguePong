class Shot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
  after_save :award_player
  before_update :change_player
  before_destroy :punish_player

  def award_player
    if player
      player.update_attributes(
        :points => player.points += however_many,
        :opp => player.calculate_opp,
        :hit_percentage => player.calculate_hit_percentage,
        :last_cups => player.last_cups += cup == 10 ? 1 : 0)

        if player.team
          player.team.update_attributes(
            :points => player.team.points += however_many)
        end
    end
  end

  def change_player
    punish_player if player_id_changed?
  end

  def punish_player
    if player
      player.update_attributes(
      :points => player.points -= however_many,
      :opp => player.calculate_opp,
      :hit_percentage => (player.shots.where("cup != 0").count.to_f / player.shots.count.to_f) * 100,
      :last_cups => player.last_cups -= cup == 10 ? 1 : 0)

      if player.team
        player.team.update_attributes(
          :points => player.team.points -= however_many)
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
