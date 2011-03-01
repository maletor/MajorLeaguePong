class Invitation < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'
  belongs_to :team

  validates_presence_of :recipient_email
  validate :recipient_is_not_registered
  validate :team_is_not_full, :unless => "team.blank?"

  before_create :generate_token

  private

  def team_is_not_full
    errors.add :team_id, 'is already full.' if team.players.count >= 3
  end

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered.' if User.find_by_email(recipient_email)
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
