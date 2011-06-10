class SilosController < ApplicationController
  # GET /silos
  # GET /silos.xml
  def index
    @silos = Silo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @silos }
    end
  end

  # GET /silos/1
  # GET /silos/1.xml
  def show
    @silo = Silo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @silo }
    end
  end

  # GET /silos/new
  # GET /silos/new.xml
  def new
    @silo = Silo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @silo }
    end
  end

  # GET /silos/1/edit
  def edit
    @silo = Silo.find(params[:id])
  end

  # POST /silos
  # POST /silos.xml
  def create
    @silo = Silo.new(params[:silo])

    respond_to do |format|
      if @silo.save
        flash[:notice] = 'Silo was successfully created.'
        format.html { redirect_to(@silo) }
        format.xml  { render :xml => @silo, :status => :created, :location => @silo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @silo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /silos/1
  # PUT /silos/1.xml
  def update
    @silo = Silo.find(params[:id])

    respond_to do |format|
      if @silo.update_attributes(params[:silo])
        flash[:notice] = 'Silo was successfully updated.'
        format.html { redirect_to(@silo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @silo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /silos/1
  # DELETE /silos/1.xml
  def destroy
    @silo = Silo.find(params[:id])
    @silo.destroy

    respond_to do |format|
      format.html { redirect_to(silos_url) }
      format.xml  { head :ok }
    end
  end
end
