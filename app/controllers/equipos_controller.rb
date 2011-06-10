class EquiposController < ApplicationController
  # GET /equipos
  # GET /equipos.xml
  def index
    @equipos = Equipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @equipos }
    end
  end

  # GET /equipos/1
  # GET /equipos/1.xml
  def show
    @equipo = Equipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @equipo }
    end
  end

  # GET /equipos/new
  # GET /equipos/new.xml
  def new
    @equipo = Equipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @equipo }
    end
  end

  # GET /equipos/1/edit
  def edit
    @equipo = Equipo.find(params[:id])
  end

  # POST /equipos
  # POST /equipos.xml
  def create
    @equipo = Equipo.new(params[:equipo])

    respond_to do |format|
      if @equipo.save
        flash[:notice] = 'Equipo was successfully created.'
        format.html { redirect_to(@equipo) }
        format.xml  { render :xml => @equipo, :status => :created, :location => @equipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @equipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /equipos/1
  # PUT /equipos/1.xml
  def update
    @equipo = Equipo.find(params[:id])

    respond_to do |format|
      if @equipo.update_attributes(params[:equipo])
        flash[:notice] = 'Equipo was successfully updated.'
        format.html { redirect_to(@equipo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @equipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /equipos/1
  # DELETE /equipos/1.xml
  def destroy
    @equipo = Equipo.find(params[:id])
    @equipo.destroy

    respond_to do |format|
      format.html { redirect_to(equipos_url) }
      format.xml  { head :ok }
    end
  end
end
