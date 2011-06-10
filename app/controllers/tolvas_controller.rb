class TolvasController < ApplicationController
  # GET /tolvas
  # GET /tolvas.xml
  def index
    @tolvas = Tolva.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tolvas }
    end
  end

  # GET /tolvas/1
  # GET /tolvas/1.xml
  def show
    @tolva = Tolva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tolva }
    end
  end

  # GET /tolvas/new
  # GET /tolvas/new.xml
  def new
    @tolva = Tolva.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tolva }
    end
  end

  # GET /tolvas/1/edit
  def edit
    @tolva = Tolva.find(params[:id])
  end

  # POST /tolvas
  # POST /tolvas.xml
  def create
    @tolva = Tolva.new(params[:tolva])

    respond_to do |format|
      if @tolva.save
        flash[:notice] = 'Tolva was successfully created.'
        format.html { redirect_to(@tolva) }
        format.xml  { render :xml => @tolva, :status => :created, :location => @tolva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tolva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tolvas/1
  # PUT /tolvas/1.xml
  def update
    @tolva = Tolva.find(params[:id])

    respond_to do |format|
      if @tolva.update_attributes(params[:tolva])
        flash[:notice] = 'Tolva was successfully updated.'
        format.html { redirect_to(@tolva) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tolva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tolvas/1
  # DELETE /tolvas/1.xml
  def destroy
    @tolva = Tolva.find(params[:id])
    @tolva.destroy

    respond_to do |format|
      format.html { redirect_to(tolvas_url) }
      format.xml  { head :ok }
    end
  end
end
