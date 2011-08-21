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

  def id(bax_id, gabarra_id = nil)
    if gabarra_id.nil?
      'bax_' + bax_id.split('/')[0] + '_' + bax_id.split('/')[1]
    else
      'gabarra_' + bax_id.split('/')[0] + '_' + bax_id.split('/')[1] + '_' + gabarra_id.split('-')[0]  + '_' + gabarra_id.split('-')[1]
    end
  end

  def habilitada(img_src)
    if img_src == 'flag_finish.png' || img_src == 'steering_wheel.png'
      'class="deshabilitada"'
    else
      nil
    end 
  end
end