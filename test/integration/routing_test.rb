require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  should 'route correctly' do
    assert_routing '/', { :controller => 'players', :action => 'index' }
  end
end
