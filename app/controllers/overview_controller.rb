class OverviewController < ApplicationController
  respond_to :html, :json

  def index
    @descargas_mes = DescargaBauxita.mes
    @descargas_temporada = DescargaBauxita.temporada
    
    respond_with @descargas_mes, @descargas_temporada
  end
end
