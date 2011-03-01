class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  before_filter :login_required

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :error => exception.message
  end
end
