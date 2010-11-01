class Round < ActiveRecord::Base
  belongs_to :game
  has_many :shots
  accepts_nested_attributes_for :shots
end
