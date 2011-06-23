# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Establece el titulo de la páginas
  def titulo(title)
    content_for(:titulo) { title }
  end
  
end
