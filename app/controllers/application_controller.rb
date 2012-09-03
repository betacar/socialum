# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Userstamp
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :asignar_variables_globales

  protected
  def asignar_variables_globales
    @areas ||= Socialum::Application.config.menu['areas']
  end
end
