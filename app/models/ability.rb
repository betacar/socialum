class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :admin
      # Administrador de la aplicación
      can :manage, :all
    elsif user.role? :sup_descargas
      # Supervisores de muelle
      can :manage, [ArriboBauxita, DescargaBauxita]
      can :read, User
    elsif user.role? :op_descargas 
      # Operadores de descarga
      can :create, ArriboBauxita
      can [:create, :update], DescargaBauxita
      can :read, User
    else
      # Otro usuario
      can :read, :all
    end
  end
end