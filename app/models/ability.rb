class Ability
  include CanCan::Ability

  def initialize(admin)

    alias_action :read, :update, :change_password, :destroy, :to => :rud

    if admin.admin?
      can :manage, :all
    end

    can :change_password, Admin do |a|
      admin.id == a.id
    end

    can :create, User if admin.domains.any?
    can :rud, User do |user|
      admin.domains.include? user.domain
    end
    cannot :read, User unless admin.admin? || admin.domains.any?

    can :create, Alias if admin.domains.any?
    can :rud, Alias do |a|
      @can = false
      @can = true if admin.domains.include? a.domain_source
      @can = true if admin.domains.include? a.domain_destination
      @can = true if admin.users.include? a.user_destination
      @can
    end
    cannot :read, Alias unless admin.admin? || admin.domains.any?

    can :create, Forwarding if admin.domains.any?
    can :rud, Forwarding do |f|
      @can = false
      @can = true if admin.domains.include? f.domain
      @can
    end
    cannot :read, Forwarding unless admin.admin? || admin.domains.any?

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
