class PasswordResetsController < ApplicationController
  skip_before_filter :login_required
  skip_authorization_check

  def create 
    @user = User.find_by_email(params[:email])
    UserMailer.reset_password(@user, reset_password_url(@user.reset_password_token)).deliver if @user
    redirect_to(root_path, :flash => { success: 'Instructions have been sent to your email.'})
  end

  def edit
    @user = User.find_by_reset_password_token(params[:reset_token])
    redirect_to root_path, :flash => { :alert => "You are not where you belong." } if !@user || logged_in?
    @token = params[:reset_token]
  end

  def update
    @user = User.find_by_reset_password_token(params[:token])

    @user.errors.add(:reset_password_token, "has expired") if @user.reset_password_email_sent_at + 3.days < Time.now

    if @user.update_attributes(params[:user].merge(reset_password_token: nil))
      session[:user_id] = @user.id
      flash[:success] = "Password reset and logged in successfully."
      redirect_to root_path
    else
      render :edit
    end
  end
end
