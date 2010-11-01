class Shot < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  belongs_to :round
end
