class PatiosController < ApplicationController
  # GET /patios
  # GET /patios.xml
  def index
    @patios = Patio.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patios }
    end
  end

  # GET /patios/1
  # GET /patios/1.xml
  def show
    @patio = Patio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patio }
    end
  end

  # GET /patios/new
  # GET /patios/new.xml
  def new
    @patio = Patio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patio }
    end
  end

  # GET /patios/1/edit
  def edit
    @patio = Patio.find(params[:id])
  end

  # POST /patios
  # POST /patios.xml
  def create
    @patio = Patio.new(params[:patio])

    respond_to do |format|
      if @patio.save
        flash[:notice] = 'Patio was successfully created.'
        format.html { redirect_to(@patio) }
        format.xml  { render :xml => @patio, :status => :created, :location => @patio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patios/1
  # PUT /patios/1.xml
  def update
    @patio = Patio.find(params[:id])

    respond_to do |format|
      if @patio.update_attributes(params[:patio])
        flash[:notice] = 'Patio was successfully updated.'
        format.html { redirect_to(@patio) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patios/1
  # DELETE /patios/1.xml
  def destroy
    @patio = Patio.find(params[:id])
    @patio.destroy

    respond_to do |format|
      format.html { redirect_to(patios_url) }
      format.xml  { head :ok }
    end
  end
end
