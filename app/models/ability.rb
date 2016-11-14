class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new # guest user (not logged in)
    alias_action :create, :read, :update, :destroy, :to => :crud

   
    if user.admin?
      can :manage, :all
    elsif user.manager? 
      can :manage, Gallery
      can :manage, GalleryType
      can :manage, AdminUser, id: user.id
      can :manage, ActiveAdmin::Page, name: "Dashboard"
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
