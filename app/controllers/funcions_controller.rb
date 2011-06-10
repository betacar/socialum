class FuncionsController < ApplicationController
  # GET /funcions
  # GET /funcions.xml
  def index
    @funcions = Funcion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @funcions }
    end
  end

  # GET /funcions/1
  # GET /funcions/1.xml
  def show
    @funcion = Funcion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @funcion }
    end
  end

  # GET /funcions/new
  # GET /funcions/new.xml
  def new
    @funcion = Funcion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @funcion }
    end
  end

  # GET /funcions/1/edit
  def edit
    @funcion = Funcion.find(params[:id])
  end

  # POST /funcions
  # POST /funcions.xml
  def create
    @funcion = Funcion.new(params[:funcion])

    respond_to do |format|
      if @funcion.save
        flash[:notice] = 'Funcion was successfully created.'
        format.html { redirect_to(@funcion) }
        format.xml  { render :xml => @funcion, :status => :created, :location => @funcion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @funcion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /funcions/1
  # PUT /funcions/1.xml
  def update
    @funcion = Funcion.find(params[:id])

    respond_to do |format|
      if @funcion.update_attributes(params[:funcion])
        flash[:notice] = 'Funcion was successfully updated.'
        format.html { redirect_to(@funcion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @funcion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /funcions/1
  # DELETE /funcions/1.xml
  def destroy
    @funcion = Funcion.find(params[:id])
    @funcion.destroy

    respond_to do |format|
      format.html { redirect_to(funcions_url) }
      format.xml  { head :ok }
    end
  end
end
