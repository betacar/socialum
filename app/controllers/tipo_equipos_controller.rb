class TipoEquiposController < ApplicationController
  # GET /tipo_equipos
  # GET /tipo_equipos.xml
  def index
    @tipo_equipos = TipoEquipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipo_equipos }
    end
  end

  # GET /tipo_equipos/1
  # GET /tipo_equipos/1.xml
  def show
    @tipo_equipo = TipoEquipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipo_equipo }
    end
  end

  # GET /tipo_equipos/new
  # GET /tipo_equipos/new.xml
  def new
    @tipo_equipo = TipoEquipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipo_equipo }
    end
  end

  # GET /tipo_equipos/1/edit
  def edit
    @tipo_equipo = TipoEquipo.find(params[:id])
  end

  # POST /tipo_equipos
  # POST /tipo_equipos.xml
  def create
    @tipo_equipo = TipoEquipo.new(params[:tipo_equipo])

    respond_to do |format|
      if @tipo_equipo.save
        flash[:notice] = 'TipoEquipo was successfully created.'
        format.html { redirect_to(@tipo_equipo) }
        format.xml  { render :xml => @tipo_equipo, :status => :created, :location => @tipo_equipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipo_equipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_equipos/1
  # PUT /tipo_equipos/1.xml
  def update
    @tipo_equipo = TipoEquipo.find(params[:id])

    respond_to do |format|
      if @tipo_equipo.update_attributes(params[:tipo_equipo])
        flash[:notice] = 'TipoEquipo was successfully updated.'
        format.html { redirect_to(@tipo_equipo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipo_equipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_equipos/1
  # DELETE /tipo_equipos/1.xml
  def destroy
    @tipo_equipo = TipoEquipo.find(params[:id])
    @tipo_equipo.destroy

    respond_to do |format|
      format.html { redirect_to(tipo_equipos_url) }
      format.xml  { head :ok }
    end
  end
end
