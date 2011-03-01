class Round < ActiveRecord::Base
  belongs_to :game, :counter_cache => true
  has_many :shots, :dependent => :destroy
  accepts_nested_attributes_for :shots, :allow_destroy => true
  validates_presence_of :number
  validates_numericality_of :number

  after_create :punch_asshole
  after_destroy :forgive_asshole

  def punch_asshole
    asshole(true)
  end

  def forgive_asshole
    asshole(false)
  end

  private

  def asshole(increment)
    shots_away = Shot.where("cup != 0 and cup != 11 and cup is not null and round_id = ? and team_id = ?", self.id, self.game.away.id)
    shots_home = Shot.where("cup != 0 and cup != 11 and cup is not null and round_id = ? and team_id = ?", self.id, self.game.home.id)

    all_shots = [shots_away, shots_home]

    all_shots.each do |shots|
      if shots.count == 2
        shots.each do |shot|
          if shot.cup == 0
            increment ? shot.player.increment(:assholes).save! : shot.player.decrement(:assholes).save!
            break
          end
        end
      end
    end
  end
end
