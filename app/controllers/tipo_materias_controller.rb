class TipoMateriasController < ApplicationController
  # GET /tipo_materias
  # GET /tipo_materias.xml
  def index
    @tipo_materias = TipoMateria.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipo_materias }
    end
  end

  # GET /tipo_materias/1
  # GET /tipo_materias/1.xml
  def show
    @tipo_materia = TipoMateria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipo_materia }
    end
  end

  # GET /tipo_materias/new
  # GET /tipo_materias/new.xml
  def new
    @tipo_materia = TipoMateria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipo_materia }
    end
  end

  # GET /tipo_materias/1/edit
  def edit
    @tipo_materia = TipoMateria.find(params[:id])
  end

  # POST /tipo_materias
  # POST /tipo_materias.xml
  def create
    @tipo_materia = TipoMateria.new(params[:tipo_materia])

    respond_to do |format|
      if @tipo_materia.save
        flash[:notice] = 'TipoMateria was successfully created.'
        format.html { redirect_to(@tipo_materia) }
        format.xml  { render :xml => @tipo_materia, :status => :created, :location => @tipo_materia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipo_materia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_materias/1
  # PUT /tipo_materias/1.xml
  def update
    @tipo_materia = TipoMateria.find(params[:id])

    respond_to do |format|
      if @tipo_materia.update_attributes(params[:tipo_materia])
        flash[:notice] = 'TipoMateria was successfully updated.'
        format.html { redirect_to(@tipo_materia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipo_materia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_materias/1
  # DELETE /tipo_materias/1.xml
  def destroy
    @tipo_materia = TipoMateria.find(params[:id])
    @tipo_materia.destroy

    respond_to do |format|
      format.html { redirect_to(tipo_materias_url) }
      format.xml  { head :ok }
    end
  end
end
