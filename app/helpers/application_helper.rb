# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Establece el titulo de la páginas
  def titulo(title)
    content_for(:titulo) { title }
  end

  def strEstado(estado)
    if estado
      'Activo'
    else
      'Inactivo'
    end
  end  

  def imgEstado(estado, selector)
    if estado
      link_to image_tag('close_16.png', :alt => '', :title => 'Desactivar'), selector
    else
      link_to image_tag('accepted_16.png', :alt => '', :title => 'Activar'), selector
    end
  end
  
  def selectEstado
    select_tag 'activo', '<option value="true">Activo</option><option value="false">Inactivo</option>'
  end
  
  def normalizar(frase)
    frase.titleize
  end
  
end
