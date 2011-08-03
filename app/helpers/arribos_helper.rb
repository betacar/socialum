module ArribosHelper
  
  # Determina si un BAX ya fue reportado. 
  # Si es false, muestra el boton para reportarlo. 
  # Caso contrario, muestra el boton deshabilitado.
  def reportado(existe, bax_id)    
    if existe
      submit_tag 'Arribo reportado', :title => 'Arribo reportado', :type => 'button', :disabled => 'disabled', :class => 'pequenio'
    else      
      submit_tag 'Reportar arribo', :title => 'Reportar arribo', :type => 'button', :name => nil, :id => nil, :class => 'blue reportar_arribo pequenio', 'data-bax' => bax_id
    end
  end
  
end
