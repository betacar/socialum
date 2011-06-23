class AlarmasController < ApplicationController
  before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
  # GET /alarmas
  # GET /alarmas.xml
  def index
    @ficha  = current_usuario.ficha
    @alarmas = Alarma.all
    @estados = Estado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alarmas }
    end
  end

  # GET /alarmas/1/edit
  def edit
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
    
        flash[:success] = '<strong>¡Éxito!</strong> La(s) alarma(s) ha(n) sido creada(s).'
        format.json { render :json => @alarmas }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # PUT /alarmas/1
  # PUT /alarmas/1.xml
  def update
    @alarma = Alarma.find(params[:id])

    respond_to do |format|
      if @alarma.update_attributes(params[:alarma])
        flash[:success] = 'Alarma was successfully updated.'
        format.html { redirect_to(@alarma) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alarma.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  # PUT /alarmas/estado/1
  # PUT /alarmas/estado/1.xml
  def estado
    @alarma = Alarma.modificar_estado(params[:id])
    @alarmas = Alarma.all
       
    respond_to do |format|
      flash[:success] = 'El estado de la alarma ha sido modificado.'
      format.html { render :action => 'index' }
      format.xml { head :ok }
    end
  end
   
end
