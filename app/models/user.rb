class User < ActiveRecord::Base
  set_table_name 'usuarios'
  has_one :empleado, :foreign_key => :id
  devise :ldap_authenticatable, :rememberable, :trackable, :timeoutable 
  model_stamper

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :ldap_attributes, :password, :remember_me
  
  def ficha
    operationsAD = OperationsAd.new
    ficha = operationsAD.Atributo('initials', self.login)
    #ficha = Devise::LdapAdapter.getAtributo('initials', self.login) # Filtro los datos en AD, a través del login, para obtener el numero de personal
    @ficha = 30000000 + ficha.to_s.to_i # Sumamos 30 millones a la ficha, segun estandar de numero de personal
  end
  
  def before_save
    self.id = self.ficha # Asigno el numero de personal como ID de usuario
  end
  
  def datos
    if (self.ficha != nil)
      @empleado = Empleado.find(self.ficha)
      
      # Obtenemos los nombres y apellidos del empleado, los llevamos a minuscula y luego 'titulizamos' el nombre completo
      @nombres = (empleado.nombres + ' ' + empleado.apellidos).titleize
    else
      self.ficha
    end
  end
end
