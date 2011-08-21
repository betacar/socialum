class UsuariosController < ApplicationController
  def index
    @usuarios = User.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def estado
  end

end
