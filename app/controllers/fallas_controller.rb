class FallasController < ApplicationController
  # GET /fallas
  # GET /fallas.xml
  def index
    @fallas = Falla.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fallas }
    end
  end

  # GET /fallas/1
  # GET /fallas/1.xml
  def show
    @falla = Falla.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @falla }
    end
  end

  # GET /fallas/new
  # GET /fallas/new.xml
  def new
    @falla = Falla.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @falla }
    end
  end

  # GET /fallas/1/edit
  def edit
    @falla = Falla.find(params[:id])
  end

  # POST /fallas
  # POST /fallas.xml
  def create
    @falla = Falla.new(params[:falla])

    respond_to do |format|
      if @falla.save
        flash[:notice] = 'Falla was successfully created.'
        format.html { redirect_to(@falla) }
        format.xml  { render :xml => @falla, :status => :created, :location => @falla }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @falla.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fallas/1
  # PUT /fallas/1.xml
  def update
    @falla = Falla.find(params[:id])

    respond_to do |format|
      if @falla.update_attributes(params[:falla])
        flash[:notice] = 'Falla was successfully updated.'
        format.html { redirect_to(@falla) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @falla.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fallas/1
  # DELETE /fallas/1.xml
  def destroy
    @falla = Falla.find(params[:id])
    @falla.destroy

    respond_to do |format|
      format.html { redirect_to(fallas_url) }
      format.xml  { head :ok }
    end
  end
end
