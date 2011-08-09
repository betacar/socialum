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
    if frase.nil?
      frase = "Vacío"
    else
      frase.titleize
    end
  end
  
  # Transforma de formato 123456,7 a 123.456,7
  # Utilizado mayormente para formatear los tonelajes
  def delimitar(num)
    number_with_precision(num, :precision => 2, :delimiter => ".", :separator => ",")
  end
  
  # Llevar a formato fecha-hora
  def getFechaHora(fecha)
    if fecha.nil?
      fecha = "No disponible"
    else
      fecha.to_datetime.to_s(:fechahora)
    end
  end
  
  # Determina si un elemento del menú está activo o no, basado en el nombre del controller
  def activo(controller)
    if current_page?(:controller => controller)
      'class="activo"'
    else
      nil
    end 
  end
  
  # Devuelve el numero en formato porcentual
  def porcentual(num)
    number_to_percentage(num, :precision => '1', :separator => ',')
  end
end
