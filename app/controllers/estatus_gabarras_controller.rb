class EstatusGabarrasController < ApplicationController
  # GET /estatus_gabarras
  # GET /estatus_gabarras.xml
  def index
    @estatus_gabarras = EstatusGabarra.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estatus_gabarras }
    end
  end

  # GET /estatus_gabarras/1
  # GET /estatus_gabarras/1.xml
  def show
    @estatus_gabarra = EstatusGabarra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estatus_gabarra }
    end
  end

  # GET /estatus_gabarras/new
  # GET /estatus_gabarras/new.xml
  def new
    @estatus_gabarra = EstatusGabarra.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estatus_gabarra }
    end
  end

  # GET /estatus_gabarras/1/edit
  def edit
    @estatus_gabarra = EstatusGabarra.find(params[:id])
  end

  # POST /estatus_gabarras
  # POST /estatus_gabarras.xml
  def create
    @estatus_gabarra = EstatusGabarra.new(params[:estatus_gabarra])

    respond_to do |format|
      if @estatus_gabarra.save
        flash[:notice] = 'EstatusGabarra was successfully created.'
        format.html { redirect_to(@estatus_gabarra) }
        format.xml  { render :xml => @estatus_gabarra, :status => :created, :location => @estatus_gabarra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @estatus_gabarra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estatus_gabarras/1
  # PUT /estatus_gabarras/1.xml
  def update
    @estatus_gabarra = EstatusGabarra.find(params[:id])

    respond_to do |format|
      if @estatus_gabarra.update_attributes(params[:estatus_gabarra])
        flash[:notice] = 'EstatusGabarra was successfully updated.'
        format.html { redirect_to(@estatus_gabarra) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estatus_gabarra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estatus_gabarras/1
  # DELETE /estatus_gabarras/1.xml
  def destroy
    @estatus_gabarra = EstatusGabarra.find(params[:id])
    @estatus_gabarra.destroy

    respond_to do |format|
      format.html { redirect_to(estatus_gabarras_url) }
      format.xml  { head :ok }
    end
  end
end
