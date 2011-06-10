class ProcesosController < ApplicationController
  # GET /procesos
  # GET /procesos.xml
  def index
    @procesos = Proceso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @procesos }
    end
  end

  # GET /procesos/1
  # GET /procesos/1.xml
  def show
    @proceso = Proceso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proceso }
    end
  end

  # GET /procesos/new
  # GET /procesos/new.xml
  def new
    @proceso = Proceso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proceso }
    end
  end

  # GET /procesos/1/edit
  def edit
    @proceso = Proceso.find(params[:id])
  end

  # POST /procesos
  # POST /procesos.xml
  def create
    @proceso = Proceso.new(params[:proceso])

    respond_to do |format|
      if @proceso.save
        flash[:notice] = 'Proceso was successfully created.'
        format.html { redirect_to(@proceso) }
        format.xml  { render :xml => @proceso, :status => :created, :location => @proceso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /procesos/1
  # PUT /procesos/1.xml
  def update
    @proceso = Proceso.find(params[:id])

    respond_to do |format|
      if @proceso.update_attributes(params[:proceso])
        flash[:notice] = 'Proceso was successfully updated.'
        format.html { redirect_to(@proceso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /procesos/1
  # DELETE /procesos/1.xml
  def destroy
    @proceso = Proceso.find(params[:id])
    @proceso.destroy

    respond_to do |format|
      format.html { redirect_to(procesos_url) }
      format.xml  { head :ok }
    end
  end
end
