# frozen_string_literal: true

# class Ability
class Ability
  include CanCan::Ability

  def initialize(user)
    # if user.user_type == 'Manager' || user.user_type == '0'
    if user.manager?
      can :manage, Project, user_id: user.id
      can :read, UserProject
      can :read, Bug
    elsif user.qa?
      can :manage, Bug
      can :index, Project
    elsif user.developer?
      can %i[index show edit update], Bug
      can :index, Project
    end
  end
end
