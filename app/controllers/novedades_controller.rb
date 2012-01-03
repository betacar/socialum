class NovedadesController < ApplicationController

  def index
    @novedades = Novedad.all

    respond_to do |format|
      format.html
    end
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def acaecimiento
    @novedad = Novedad.new

    respond_to do |format|
      format.html { render :partial => 'new_acaecimiento', :layout => false, :locals => { :novedad => @novedad } }
    end
  end
end
