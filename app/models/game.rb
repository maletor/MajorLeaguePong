class Game < ActiveRecord::Base
  has_many :shots, :dependent => :destroy
  has_many :rounds, :dependent => :destroy
  accepts_nested_attributes_for :shots
  belongs_to :away, :class_name => 'Team'
  belongs_to :home, :class_name => 'Team'

  has_and_belongs_to_many :players
  
  def winner
    shots.each do |s|
      return s.player.team if s.cup == 10
    end
    nil
  end

end

