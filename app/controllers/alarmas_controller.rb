class AlarmasController < ApplicationController
  #before_filter :authenticate_usuario! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
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
        format.html { render :action => 'index' }
        format.xml  { render :xml => @alarma, :status => :created, :location => @alarma }
        format.js { render :layout => false }
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
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  def estado
    @alarma = Alarma.modificar_estado(params[:id])
    @alarmas = Alarma.all
       
    respond_to do |format|
      flash[:notice] = 'El estado de la alarma ha sido modificado.'
      format.html { render :action => 'index' }
      format.xml { head :ok }
    end
  end
   
end
