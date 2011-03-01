class SessionsController < ApplicationController
  skip_before_filter :login_required

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully."
      redirect_to_target_or_default("/")
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been successfully logged out."
    redirect_to "/"
  end
end
