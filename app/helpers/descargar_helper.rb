module DescargarHelper
  
  # Determina si un BAX ya fue reportado. 
  # Si es false, muestra el boton para reportarlo. 
  # Caso contrario, muestra el boton deshabilitado.
  def atracada(existe, bax_id, gabarra_id)    
    if existe
      submit_tag 'Reportado', :title => 'Atraque reportado', :type => 'button', :disabled => 'disabled', :class => 'pequenio'
    else      
      submit_tag 'Reportar atraque', :title => 'Reportar atraque', :type => 'button', :name => 'reportar_atraque', :id => nil, :class => 'reportar_atraque pequenio', 'data-bax' => bax_id, 'data-gabarra' => gabarra_id
    end
  end
end
