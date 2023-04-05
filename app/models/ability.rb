# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.manager?
      can :manage, Project, user_id: user.id
      can :read, UserProject
      can :read, Bug
    elsif user.qa?
      can :manage, Bug
      can :read, Project
    elsif user.developer?
      can [:index,:show,:edit,:update], Bug
      can :read, Project
    end
    # if user.manager?
    #   can :manage, Project
    # else
    #   can :index, Project
    # end
  end
end
