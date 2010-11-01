class Game < ActiveRecord::Base
  has_many :shots
  has_many :rounds
  accepts_nested_attributes_for :shots
  belongs_to :away, :class_name => 'Team'
  belongs_to :home, :class_name => 'Team'

  def players
    away.players + home.players
  end
end
