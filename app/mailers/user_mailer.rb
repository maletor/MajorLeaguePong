class UserMailer < ActionMailer::Base
  default :from => "Major League Pong <notifications@majorleaguepong.org>"
  
  def invitation(invitation, signup_with_invite_url)
    @invitation = invitation
    @url = signup_with_invite_url

    invitation.update_attribute(:sent_at, Time.now)
    mail(to: "#{invitation.name} <#{invitation.recipient_email}>", subject: "Invitation to Major League Pong")
  end

  def reset_password(user, reset_password_url)
    @user = user
    @url = reset_password_url

    user.update_attribute(:reset_password_email_sent_at, Time.now)
    mail(to: "#{user.player.name} <#{user.email}>", subject: "Forgot Password at Major League Pong")
  end
end
