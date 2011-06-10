class TipoTransportesController < ApplicationController
  # GET /tipo_transportes
  # GET /tipo_transportes.xml
  def index
    @tipo_transportes = TipoTransporte.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipo_transportes }
    end
  end

  # GET /tipo_transportes/1
  # GET /tipo_transportes/1.xml
  def show
    @tipo_transporte = TipoTransporte.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipo_transporte }
    end
  end

  # GET /tipo_transportes/new
  # GET /tipo_transportes/new.xml
  def new
    @tipo_transporte = TipoTransporte.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipo_transporte }
    end
  end

  # GET /tipo_transportes/1/edit
  def edit
    @tipo_transporte = TipoTransporte.find(params[:id])
  end

  # POST /tipo_transportes
  # POST /tipo_transportes.xml
  def create
    @tipo_transporte = TipoTransporte.new(params[:tipo_transporte])

    respond_to do |format|
      if @tipo_transporte.save
        flash[:notice] = 'TipoTransporte was successfully created.'
        format.html { redirect_to(@tipo_transporte) }
        format.xml  { render :xml => @tipo_transporte, :status => :created, :location => @tipo_transporte }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipo_transporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_transportes/1
  # PUT /tipo_transportes/1.xml
  def update
    @tipo_transporte = TipoTransporte.find(params[:id])

    respond_to do |format|
      if @tipo_transporte.update_attributes(params[:tipo_transporte])
        flash[:notice] = 'TipoTransporte was successfully updated.'
        format.html { redirect_to(@tipo_transporte) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipo_transporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_transportes/1
  # DELETE /tipo_transportes/1.xml
  def destroy
    @tipo_transporte = TipoTransporte.find(params[:id])
    @tipo_transporte.destroy

    respond_to do |format|
      format.html { redirect_to(tipo_transportes_url) }
      format.xml  { head :ok }
    end
  end
end
