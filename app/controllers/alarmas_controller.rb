class AlarmasController < ApplicationController
  before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
  # GET /alarmas
  # GET /alarmas.xml
  def index
    @ficha  = current_usuario.ficha
    @alarmas = Alarma.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alarmas }
    end
  end

  # GET /alarmas/1
  # GET /alarmas/1.xml
  def show
    @alarma = Alarma.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alarma }
    end
  end

  # GET /alarmas/new
  # GET /alarmas/new.xml
  def new
    @alarma = Alarma.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alarma }
    end
  end

  # GET /alarmas/1/edit
  def edit
    @alarma = Alarma.find(params[:id])
  end

  # POST /alarmas
  # POST /alarmas.xml
  def create
    @alarma = Alarma.new(params[:alarma])

    respond_to do |format|
      if @alarma.save
        flash[:notice] = 'Alarma was successfully created.'
        format.html { redirect_to(@alarma) }
        format.xml  { render :xml => @alarma, :status => :created, :location => @alarma }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @alarma.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alarmas/1
  # PUT /alarmas/1.xml
  def update
    @alarma = Alarma.find(params[:id])

    respond_to do |format|
      if @alarma.update_attributes(params[:alarma])
        flash[:notice] = 'Alarma was successfully updated.'
        format.html { redirect_to(@alarma) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alarma.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def activar
    # Se cambia el estado de la tupla de inactiva a Activa.
    @alarma = Alarma.find(params[:id])
    
    respond_to do |format|
      if @alarma.update_attribute(param[:estado_id], 1)
        flash[:notice] = 'La alarma ha sido activada.'
        format.html { redirect_to(alarmas_url) }
        format.xml { head :ok }
      else
       format.html { render :action => "index" } 
       format.xml { render :xml => @alarmas }
      end

    end
  end

  def desactivar
    # No existe destrucción (DELETE) física de data. 
    # Solo se cambia el estado de la tupla de Activa a Inactiva.
    @alarma = Alarma.find(params[:id])
    #@alarma.destroy
    
    respond_to do |format|
      if @alarma.update_attribute(param[:estado_id], 2)
        flash[:notice] = 'La alarma fue desactivada.'
        format.html { redirect_to(alarmas_url) }
        format.xml { head :ok }
      else
       format.html { render :action => "index" } 
       format.xml { render :xml => @alarmas }
      end

    #respond_to do |format|
    #  format.html { redirect_to(alarmas_url) }
    #  format.xml  { head :ok }
    end
  end  
end
