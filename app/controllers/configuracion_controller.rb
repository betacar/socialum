class ConfiguracionController < ApplicationController
  before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  def index
  end
end
