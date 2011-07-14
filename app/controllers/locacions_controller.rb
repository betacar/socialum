class LocacionsController < ApplicationController
  before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
  # GET /locacions
  def index
    @locacions = Locacion.all

    render :partial => 'index', :layout => false, :locals => { :locacions => @locacions }
  end

  # GET /locacions/1
  def show
    @locacion = Locacion.find(params[:id])

    respond_to do |format|
      format.json  { render :json => @locacion }
    end
  end

  # POST /locacions
  def create
    respond_to do |format|
      begin        
        @locacion = Locacion.guardar(params[:locacion])
        format.json { render :json => @locacion }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # PUT /locacions/1
  def update
    respond_to do |format|
      begin
        @locacion = Locacion.actualizar(params)
        format.json { render :json => @locacion }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # Se cambia el estado de la tupla de Inactiva a Activa.
  # PUT /locacions/estado/1
  def estado      
    respond_to do |format|
      @locacion = Locacion.modificar_estado(params[:id])
      
      format.json { render :json => @locacion }
    end
  end
end
