# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Establece el titulo de la páginas
  def titulo(title)
    content_for(:titulo) { title }
  end

  def main_clases(clases)
    content_for(:main_clases) { clases }
  end

  # Determina si un elemento del menú está activo o no, basado en el nombre del controller
  def activo(controller)
    if params[:controller] == controller
      'activo'
    else
      nil
    end
  end
end