class User < ActiveRecord::Base
  self.table_name = :usuarios
  has_one :empleado, :foreign_key => :id
  has_and_belongs_to_many :roles
  devise :database_authenticatable, :rememberable, :trackable, :timeoutable
  model_stamper

  validates_associated :empleado

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :password, :remember_me, :password_confirmation

  # def ficha
  #   operationsAD = OperationsAd.new
  #   ficha = operationsAD.Atributo('initials', self.login)
  #   #ficha = Devise::LdapAdapter.getAtributo('initials', self.login) # Filtro los datos en AD, a través del login, para obtener el numero de personal
  #   @ficha = 30000000 + ficha.to_s.to_i # Sumamos 30 millones a la ficha, segun estandar de numero de personal
  # end

  # def before_save
  #   self.id = self.ficha # Asigno el numero de personal como ID de usuario
  # end
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end
end

