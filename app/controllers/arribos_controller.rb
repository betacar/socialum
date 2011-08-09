class ArribosController < ApplicationController
  before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
  #GET /arribos
  def index
    @baxes = Bax.trenes
    
    respond_to do |format|
      format.html
      format.json { render :json => @baxes }
    end
  end
  
  # POST /arribos/reportar/001/2006/
  def reportar
    respond_to do |format|
      begin
        @arribo = ArriboBauxita.arribo(params)
        format.json { render :json => @arribo }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end
end
