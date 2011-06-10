class LocacionsController < ApplicationController
  # GET /locacions
  # GET /locacions.xml
  def index
    @locacions = Locacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locacions }
    end
  end

  # GET /locacions/1
  # GET /locacions/1.xml
  def show
    @locacion = Locacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @locacion }
    end
  end

  # GET /locacions/new
  # GET /locacions/new.xml
  def new
    @locacion = Locacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @locacion }
    end
  end

  # GET /locacions/1/edit
  def edit
    @locacion = Locacion.find(params[:id])
  end

  # POST /locacions
  # POST /locacions.xml
  def create
    @locacion = Locacion.new(params[:locacion])

    respond_to do |format|
      if @locacion.save
        flash[:notice] = 'Locacion was successfully created.'
        format.html { redirect_to(@locacion) }
        format.xml  { render :xml => @locacion, :status => :created, :location => @locacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @locacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locacions/1
  # PUT /locacions/1.xml
  def update
    @locacion = Locacion.find(params[:id])

    respond_to do |format|
      if @locacion.update_attributes(params[:locacion])
        flash[:notice] = 'Locacion was successfully updated.'
        format.html { redirect_to(@locacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @locacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locacions/1
  # DELETE /locacions/1.xml
  def destroy
    @locacion = Locacion.find(params[:id])
    @locacion.destroy

    respond_to do |format|
      format.html { redirect_to(locacions_url) }
      format.xml  { head :ok }
    end
  end
end
