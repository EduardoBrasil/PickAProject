class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :user
      can :manage, Project, :owner_id => user.id
      can :create, Project
    end
    can :read, Project
  end
end
