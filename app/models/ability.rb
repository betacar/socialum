class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :super_admin
        can :manage, :all
    elsif user.role? :admin_descargas
        can :manage, [ArriboBauxita,ArriboBuque,DescargaBauxita]
        can :read, User
    elsif user.role? :usuario_logueado
        can :read, :all
    else
      can :read, :all
    end
  end
end

