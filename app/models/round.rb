class Round < ActiveRecord::Base
  belongs_to :game, :counter_cache => true
  has_many :shots, :dependent => :destroy
  accepts_nested_attributes_for :shots

end
