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
end
