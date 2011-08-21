class EmpleadoController < ApplicationController
  before_filter :authenticate_user! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  def index
    if (params[:id].nil?)
      session[:current_ficha] = current_user.ficha
    else
      session[:current_ficha] = params[:id]
    end
    
    @empleado = Empleado.find(:all, :conditions => ['numero_personal = ?', session[:current_ficha]])
    
    if (@empleado != nil)
      return @empleado
    else
      flash[:notice] = 'No se encontraron datos'
    end
  end
  
  def show
    session[:current_ficha] = params[:id]                                                                                       
    @empleado = Empleado.find(session[:current_ficha])
    
    if(@empleado != nil)
      respond_to do |format|
        format.html 
        format.xml  { render :xml => @empleado }
      end
    else
      flash[:notice] = 'No se encuentran valores'
      redirect_to(:action => 'index')
    end 
  end
end
