class TransportesController < ApplicationController
  # GET /transportes
  # GET /transportes.xml
  def index
    @transportes = Transporte.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transportes }
    end
  end

  # GET /transportes/1
  # GET /transportes/1.xml
  def show
    @transporte = Transporte.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transporte }
    end
  end

  # GET /transportes/new
  # GET /transportes/new.xml
  def new
    @transporte = Transporte.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transporte }
    end
  end

  # GET /transportes/1/edit
  def edit
    @transporte = Transporte.find(params[:id])
  end

  # POST /transportes
  # POST /transportes.xml
  def create
    @transporte = Transporte.new(params[:transporte])

    respond_to do |format|
      if @transporte.save
        flash[:notice] = 'Transporte was successfully created.'
        format.html { redirect_to(@transporte) }
        format.xml  { render :xml => @transporte, :status => :created, :location => @transporte }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transportes/1
  # PUT /transportes/1.xml
  def update
    @transporte = Transporte.find(params[:id])

    respond_to do |format|
      if @transporte.update_attributes(params[:transporte])
        flash[:notice] = 'Transporte was successfully updated.'
        format.html { redirect_to(@transporte) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transportes/1
  # DELETE /transportes/1.xml
  def destroy
    @transporte = Transporte.find(params[:id])
    @transporte.destroy

    respond_to do |format|
      format.html { redirect_to(transportes_url) }
      format.xml  { head :ok }
    end
  end
end
