class EstadosController < ApplicationController
  
  
  # GET /estados
  def index
    @estados = Estado.all

    render :partial => 'index', :layout => false, :locals => { :estados => @estados }
  end

  # GET /estados/1
  def show
    @estado = Estado.find(params[:id])

    respond_to do |format|
      format.json  { render :json => @estado }
    end
  end

  # POST /estados
  def create
    respond_to do |format|
      begin        
        @estado = Estado.guardar(params[:estado])
        format.json { render :json => @estados }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # PUT /estados/1
  def update
    respond_to do |format|
      begin
        @estado = Estado.actualizar(params)
        format.json { render :json => @estado }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end  
end
