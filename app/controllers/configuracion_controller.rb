class ConfiguracionController < ApplicationController
  before_filter :authenticate_admin! # Autentica el usuario contra LDAP, y verifica si es administrador
  def index
    
  end
end
