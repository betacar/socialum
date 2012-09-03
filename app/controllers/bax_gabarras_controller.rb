class BaxGabarrasController < ApplicationController
  respond_to :html, :json

  def index
    @bax_gabarras = BaxGabarra.find(params[:bax_id])
  end

  def show
    @bax_gabarra = BaxGabarra.find(params[:bax_id], params[:gabarra_id])
  end
end
