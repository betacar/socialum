class AlarmasController < ApplicationController
  before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
  # GET /alarmas
  # GET /alarmas.xml
  def index
    @ficha  = current_usuario.ficha
    @alarmas = Alarma.all
    @estados = Estado.all

    render :partial => 'index', :layout => false, :locals => { :alarmas => @alarmas }
  end

  # GET /alarmas/1
  def show
    @alarma = Alarma.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => @alarma }
    end
  end

  # POST /alarmas
  # POST /alarmas.xml
  def create
    respond_to do |format|
      begin        
        @alarmas = Alarma.guardar(params[:alarma])
        format.json { render :json => @alarmas }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # PUT /alarmas/1
  # PUT /alarmas/1.xml
  def update
    respond_to do |format|
      begin
        @alarma = Alarma.actualizar(params)
        format.json { render :json => @alarma }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  # PUT /alarmas/estado/1
  # PUT /alarmas/estado/1.xml
  def estado      
    respond_to do |format|
      @alarma = Alarma.modificar_estado(params[:id])
      
      format.json { render :json => @alarma }
    end
  end
end
