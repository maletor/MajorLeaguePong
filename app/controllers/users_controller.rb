class UsersController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  def new
    unless Invitation.find_by_token(params[:invitation_token])
      redirect_to(login_url, :flash => { :error => "You must be invited to sign up." })
    else
      @user = User.new(:invitation_token => params[:invitation_token])
      player = @user.build_player
      player.team = @user.invitation.team
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up. You are now logged in."
      redirect_to "/"
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
    @player = @user.player
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to(@user.player, :flash => { :success => 'Player was successfully updated.' }) 
    else
      render :action => 'edit'
    end
  end
end
