class ArribosController < ApplicationController
  before_filter :authenticate_user! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  
  #GET /arribos
  def index
    @baxes = Bax.trenes
    @buques = Buque.all(:conditions => {:activo => true, :descargado_buque => false}, :order => 'eta_mtz_buque')
    
    respond_to do |format|
      format.html
      format.json { render :json => @baxes }
    end
  end
  
  # POST /arribos/reportar/001/2006/
  def reportar
    respond_to do |format|
      begin
        @arribo = ArriboBauxita.arribo(params)
        format.json { render :json => @arribo }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  # GET /arribos/gabarras/001/2006/
  def gabarras
    respond_to do |format|
      begin
        @gabarras = BaxGabarra.gabarras(params[:num_zarpe] + '/' + params[:anio_zarpe])
        format.html { render :partial => 'gabarras', :layout => false, :locals => { :gabarras => @gabarras } }
        format.json { render :json => @gabarras }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end
    end
  end

  def gabarra
    respond_to do |format|
      begin
        @gabarra = BaxGabarra.gabarra(params)
        
        format.html { render :partial => 'gabarra', :layout => false, :locals => { :gabarra => @gabarra } }
        format.json { render :json => @gabarra }
      rescue Exceptions::PresenciaValoresExcepcion => errores
        format.json { render :json => errores.errors, :status => 400 }
      end 
    end
  end

  def buque
    @buque = Buque.info(params[:id])

    respond_to do |format|
      if @buque
        format.html { render :partial => 'buque', :layout => false, :locals => { :buque => @buque } }
        format.json { render :json => @buque }
      else
        format.json { render :json => @buque.errors, :status => :unprocessable_entity }
      end
    end
  end
end