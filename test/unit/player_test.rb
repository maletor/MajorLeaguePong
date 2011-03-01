require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  context "a player" do
    should have_many :shots

    setup do
      @player = Factory(:player)
    end
    
    should "shot cups to make points" do
      assert true
    end
  

  end
end
