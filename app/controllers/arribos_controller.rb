class ArribosController < ApplicationController
  def index
    @baxes = Bax.all
    
    respond_to do |format|
      format.html
      format.json { render :json => @baxes }
    end
  end

  def reportArribo(bax)
    
  end
end
