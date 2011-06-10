class PuntoTolvasController < ApplicationController
  # GET /punto_tolvas
  # GET /punto_tolvas.xml
  def index
    @punto_tolvas = PuntoTolva.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @punto_tolvas }
    end
  end

  # GET /punto_tolvas/1
  # GET /punto_tolvas/1.xml
  def show
    @punto_tolva = PuntoTolva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @punto_tolva }
    end
  end

  # GET /punto_tolvas/new
  # GET /punto_tolvas/new.xml
  def new
    @punto_tolva = PuntoTolva.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @punto_tolva }
    end
  end

  # GET /punto_tolvas/1/edit
  def edit
    @punto_tolva = PuntoTolva.find(params[:id])
  end

  # POST /punto_tolvas
  # POST /punto_tolvas.xml
  def create
    @punto_tolva = PuntoTolva.new(params[:punto_tolva])

    respond_to do |format|
      if @punto_tolva.save
        flash[:notice] = 'PuntoTolva was successfully created.'
        format.html { redirect_to(@punto_tolva) }
        format.xml  { render :xml => @punto_tolva, :status => :created, :location => @punto_tolva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @punto_tolva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /punto_tolvas/1
  # PUT /punto_tolvas/1.xml
  def update
    @punto_tolva = PuntoTolva.find(params[:id])

    respond_to do |format|
      if @punto_tolva.update_attributes(params[:punto_tolva])
        flash[:notice] = 'PuntoTolva was successfully updated.'
        format.html { redirect_to(@punto_tolva) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @punto_tolva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /punto_tolvas/1
  # DELETE /punto_tolvas/1.xml
  def destroy
    @punto_tolva = PuntoTolva.find(params[:id])
    @punto_tolva.destroy

    respond_to do |format|
      format.html { redirect_to(punto_tolvas_url) }
      format.xml  { head :ok }
    end
  end
end
