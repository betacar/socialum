class ConfiguracionController < ApplicationController
  #before_filter :authenticate_admin! # Autentica el usuario contra LDAP, y verifica si es administrador
  def index
    @alarmas = Alarma.all
    @estados = Estado.all
    @usuarios = Usuario.all
    @empresas = Empresa.all    
  end
end
