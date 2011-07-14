class EmpresasController < ApplicationController
  before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
  # GET /empresas
  def index
    @ficha  = current_usuario.ficha
    @empresas = Empresa.all

    render :partial => 'index', :layout => false, :locals => { :empresas => @empresas }
  end

  # GET /empresas/1
  def show
    @empresa = Empresa.find(params[:id])

    respond_to do |format|
      format.json  { render :json => @empresa }
    end
  end

  # POST /empresas
  def create
    respond_to do |format|
      begin        
        @empresa = Empresa.guardar(params[:empresa])
        format.json { render :json => @empresas }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # PUT /empresas/1
  def update
    respond_to do |format|
      begin
        @empresa = Empresa.actualizar(params)
        format.json { render :json => @empresa }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # Se cambia el estado de la tupla de Inactiva a Activa.
  # PUT /alarmas/estado/1
  def estado      
    respond_to do |format|
      @empresa = Empresa.modificar_estado(params[:id])
      
      format.json { render :json => @empresa }
    end
  end
end
