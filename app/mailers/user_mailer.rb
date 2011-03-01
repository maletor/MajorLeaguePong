class UserMailer < ActionMailer::Base
  default :from => "Major League Pong <notifications@majorleaguepong.org>"

  def invitation(invitation, signup_with_invite_url)
    @invitation = invitation
    @url = signup_with_invite_url

    invitation.update_attribute(:sent_at, Time.now)
    mail(to: "#{invitation.name} <#{invitation.recipient_email}>", subject: "Invitation to Major League Pong")
  end
end
