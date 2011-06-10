class RolsController < ApplicationController
  # GET /rols
  # GET /rols.xml
  def index
    @rols = Rol.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rols }
    end
  end

  # GET /rols/1
  # GET /rols/1.xml
  def show
    @rol = Rol.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rol }
    end
  end

  # GET /rols/new
  # GET /rols/new.xml
  def new
    @rol = Rol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rol }
    end
  end

  # GET /rols/1/edit
  def edit
    @rol = Rol.find(params[:id])
  end

  # POST /rols
  # POST /rols.xml
  def create
    @rol = Rol.new(params[:rol])

    respond_to do |format|
      if @rol.save
        flash[:notice] = 'Rol was successfully created.'
        format.html { redirect_to(@rol) }
        format.xml  { render :xml => @rol, :status => :created, :location => @rol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rols/1
  # PUT /rols/1.xml
  def update
    @rol = Rol.find(params[:id])

    respond_to do |format|
      if @rol.update_attributes(params[:rol])
        flash[:notice] = 'Rol was successfully updated.'
        format.html { redirect_to(@rol) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rols/1
  # DELETE /rols/1.xml
  def destroy
    @rol = Rol.find(params[:id])
    @rol.destroy

    respond_to do |format|
      format.html { redirect_to(rols_url) }
      format.xml  { head :ok }
    end
  end
end
