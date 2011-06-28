class InvitationsController < ApplicationController
  load_and_authorize_resource
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      UserMailer.invitation(@invitation, signup_with_invite_url(@invitation.token)).deliver
      flash[:success] = "Thank you, invitation sent."
      redirect_to players_path
    else
      render :action => 'new'
    end
  end
end
