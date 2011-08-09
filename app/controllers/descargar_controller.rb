class DescargarController < ApplicationController
  
  # GET /descargar/gabarra/001/2006/ABC-123/
  # GET /descargar/gabarra/001/2006/ABC-123.html
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

  # GET /descargar/buque/1
  # GET /descargar/buque/1.html
  def buque
  end
end
