class BaxsController < ApplicationController
  before_filter :authenticate_user! # Autentica cada usuario contra LDAP antes de ejecutar cualquier controller
  respond_to :html, :json
  
  def index
    @baxes = Bax.embarques.all
    respond_with @baxes
  end

  def show
    @bax = Bax.find(params[:id])
    respond_with @bax
  end
end