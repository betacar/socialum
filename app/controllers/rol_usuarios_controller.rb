class RolUsuariosController < ApplicationController
  # GET /rol_usuarios
  # GET /rol_usuarios.xml
  def index
    @rol_usuarios = RolUsuario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rol_usuarios }
    end
  end

  # GET /rol_usuarios/1
  # GET /rol_usuarios/1.xml
  def show
    @rol_usuario = RolUsuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rol_usuario }
    end
  end

  # GET /rol_usuarios/new
  # GET /rol_usuarios/new.xml
  def new
    @rol_usuario = RolUsuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rol_usuario }
    end
  end

  # GET /rol_usuarios/1/edit
  def edit
    @rol_usuario = RolUsuario.find(params[:id])
  end

  # POST /rol_usuarios
  # POST /rol_usuarios.xml
  def create
    @rol_usuario = RolUsuario.new(params[:rol_usuario])

    respond_to do |format|
      if @rol_usuario.save
        flash[:notice] = 'RolUsuario was successfully created.'
        format.html { redirect_to(@rol_usuario) }
        format.xml  { render :xml => @rol_usuario, :status => :created, :location => @rol_usuario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rol_usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rol_usuarios/1
  # PUT /rol_usuarios/1.xml
  def update
    @rol_usuario = RolUsuario.find(params[:id])

    respond_to do |format|
      if @rol_usuario.update_attributes(params[:rol_usuario])
        flash[:notice] = 'RolUsuario was successfully updated.'
        format.html { redirect_to(@rol_usuario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rol_usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rol_usuarios/1
  # DELETE /rol_usuarios/1.xml
  def destroy
    @rol_usuario = RolUsuario.find(params[:id])
    @rol_usuario.destroy

    respond_to do |format|
      format.html { redirect_to(rol_usuarios_url) }
      format.xml  { head :ok }
    end
  end
end
