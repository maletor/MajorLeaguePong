class UserMailer < ActionMailer::Base
  def invitation(invitation, signup_with_invite_url)
    @invitation = invitation
    @url = signup_with_invite_url

    invitation.update_attribute(:sent_at, Time.now)
    mail(from: "Major League Pong <notifications@majorleaguepong.org>", to: "#{invitation.name} <#{invitation.recipient_email}>", subject: "Invitation to Major League Pong")
  end
end
