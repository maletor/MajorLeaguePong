class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  private
    
  def calculate_std_dev(model, column)
    Math.sqrt(model.all.inject(0) { |sum, u| sum + (u.opp - model.average(column)) ** 2 } / model.all.length.to_f )
  end
  
end
