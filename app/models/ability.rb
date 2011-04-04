class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user
      can :update, Player, :user_id == user.id

      can :update, Team do |team|
        team.players.include?(user.player)
      end

      if user.email == "eberner@gmail.com" || user.email == "bjennings88@gmail.com" || user.email == "josh@jsteiner.me"
        can :manage, :all
      end
    end
  end
end
