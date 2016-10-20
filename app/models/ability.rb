class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, Gallery
      can :manage, GalleryType
      can :manage, AdminUser, id: user.id
      can :manage, ActiveAdmin::Page, name: "Dashboard"

    end

    # can :manage, Post
    # can :read, User
    # can :manage, User, id: user.id
    # can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: :admin

  end

end
