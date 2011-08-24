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

  def campo_habilitado(field)
    if field.nil?
      false
    else
      true
    end
  end

  def status_submit(atraque, inicio, fin)
    boton = Hash.new

    if !fin.nil?
      boton = { :texto => 'Enviar desatraque', :status => 'desatraque' }
    else
      if !inicio.nil?
        boton = { :texto => 'Enviar fin de descarga', :status => 'fin_descarga' }
      else
        if !atraque.nil?
          boton = { :texto => 'Enviar inicio de descarga', :status => 'inicio_descarga' }
        else
          boton = { :texto => 'Enviar atraque', :status => 'atraque' }
        end
      end
    end

    submit_tag boton[:texto], :name => 'submit_campo', :id => 'submit_campo', :class => 'green pequenio', 'data-bax' => @gabarra.bax_id, 'data-gabarra' => @gabarra.gabarra_id, 'data-status' => boton[:status]
  end
end