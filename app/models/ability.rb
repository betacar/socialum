class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin # Puede administrar todo
      can :manage, :all
    elsif user.role? :op_descargas # Puede operar los arribos y descargas de BAX y Buques
      can :manage, [ArriboBauxita, DescargaBauxita]
      can :read, User
    elsif user.role? :usuario_logueado
      can :read, :all
    else
      can :read, :all
    end
  end
end