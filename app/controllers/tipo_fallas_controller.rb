class TipoFallasController < ApplicationController
  # GET /tipo_fallas
  # GET /tipo_fallas.xml
  def index
    @tipo_fallas = TipoFalla.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipo_fallas }
    end
  end

  # GET /tipo_fallas/1
  # GET /tipo_fallas/1.xml
  def show
    @tipo_falla = TipoFalla.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipo_falla }
    end
  end

  # GET /tipo_fallas/new
  # GET /tipo_fallas/new.xml
  def new
    @tipo_falla = TipoFalla.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipo_falla }
    end
  end

  # GET /tipo_fallas/1/edit
  def edit
    @tipo_falla = TipoFalla.find(params[:id])
  end

  # POST /tipo_fallas
  # POST /tipo_fallas.xml
  def create
    @tipo_falla = TipoFalla.new(params[:tipo_falla])

    respond_to do |format|
      if @tipo_falla.save
        flash[:notice] = 'TipoFalla was successfully created.'
        format.html { redirect_to(@tipo_falla) }
        format.xml  { render :xml => @tipo_falla, :status => :created, :location => @tipo_falla }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipo_falla.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_fallas/1
  # PUT /tipo_fallas/1.xml
  def update
    @tipo_falla = TipoFalla.find(params[:id])

    respond_to do |format|
      if @tipo_falla.update_attributes(params[:tipo_falla])
        flash[:notice] = 'TipoFalla was successfully updated.'
        format.html { redirect_to(@tipo_falla) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipo_falla.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_fallas/1
  # DELETE /tipo_fallas/1.xml
  def destroy
    @tipo_falla = TipoFalla.find(params[:id])
    @tipo_falla.destroy

    respond_to do |format|
      format.html { redirect_to(tipo_fallas_url) }
      format.xml  { head :ok }
    end
  end
end
