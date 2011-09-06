class BuquesController < ApplicationController
  
  # GET /buques/new
  # GET /buques/new.json
  def new
    @buque = Buque.nuevo

    respond_to do |format|
      format.html
      format.json { render :json => @buque }
    end
  end

  # POST /buques
  # POST /buques.json
  def create
    @buque = Buque.guardar(params)

    respond_to do |format|
      if @buque
        flash[:notice] = 'Se ha registrado el buque exitosamente.'
        format.html { redirect_to :controller => 'arribos' }
        format.json { render :json => @buque }
      else
        format.html { render :action => 'new' }
        format.json { render :json => @buque.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @buque = Buque.buscar_editar(params[:id])
  end

  def update 
    @buque = Buque.actualizar(params)

    respond_to do |format|
      if @buque
        flash[:notice] = 'Se ha actualizado el buque exitosamente.'
        format.html { redirect_to :controller => 'arribos' }
        format.json { render :json => @buque }
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @buque.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @buque = Buque.find(params[:id])
    @buque.toggle!(:activo)

    respond_to do |format|
      if @buque
        format.json { render :json => @buque }
      else
        format.json { render :json => @buque.errors, :status => :unprocessable_entity }
      end
    end
  end

  def reportar
    @buque = Buque.reportar(params[:id])

    respond_to do |format|
      if @buque
        format.json { render :json => @buque }
      else
        format.json { render :json => @buque.errors, :status => :unprocessable_entity }
      end
    end
  end

  def descargar
    # @buque = Buque.find(params[:id])

    # respond_to do |format|
    #   if @buque
    #     if @buque.id == 1
    #     format.json { render :json => @buque }
    #   else
    #     format.json { render :json => @buque.errors, :status => :unprocessable_entity }
    #   end
    # end
  end
end
