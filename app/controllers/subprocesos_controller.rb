class SubprocesosController < ApplicationController
  # GET /subprocesos
  # GET /subprocesos.xml
  def index
    @subprocesos = Subproceso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subprocesos }
    end
  end

  # GET /subprocesos/1
  # GET /subprocesos/1.xml
  def show
    @subproceso = Subproceso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subproceso }
    end
  end

  # GET /subprocesos/new
  # GET /subprocesos/new.xml
  def new
    @subproceso = Subproceso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subproceso }
    end
  end

  # GET /subprocesos/1/edit
  def edit
    @subproceso = Subproceso.find(params[:id])
  end

  # POST /subprocesos
  # POST /subprocesos.xml
  def create
    @subproceso = Subproceso.new(params[:subproceso])

    respond_to do |format|
      if @subproceso.save
        flash[:notice] = 'Subproceso was successfully created.'
        format.html { redirect_to(@subproceso) }
        format.xml  { render :xml => @subproceso, :status => :created, :location => @subproceso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subproceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subprocesos/1
  # PUT /subprocesos/1.xml
  def update
    @subproceso = Subproceso.find(params[:id])

    respond_to do |format|
      if @subproceso.update_attributes(params[:subproceso])
        flash[:notice] = 'Subproceso was successfully updated.'
        format.html { redirect_to(@subproceso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subproceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subprocesos/1
  # DELETE /subprocesos/1.xml
  def destroy
    @subproceso = Subproceso.find(params[:id])
    @subproceso.destroy

    respond_to do |format|
      format.html { redirect_to(subprocesos_url) }
      format.xml  { head :ok }
    end
  end
end
