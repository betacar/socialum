class BaxGabarra < ActiveRecord::Base
  set_table_name 'vw_zarpes_gabarras'
  belongs_to :bax
  has_one :DescargaBauxita
  attr_accessor :analisis, :equipos, :status_img # Atributos virtuales para almacenar los analisis de laboratorio y los equipos de descarga
  
  # Retorna los datos relativos a una gabarra de un BAX, para ser descargada
  def self.gabarra(params)
    gabarra = self.find_by_bax_id_and_gabarra_id(params[:num_zarpe] + '/' + params[:anio_zarpe], params[:gabarra_id])
    
    if gabarra.nil?
      raise Exceptions::PresenciaValoresExcepcion.new('La gabarra ' + params[:gabarra_id] + ' no está asociada al BAX ' + params[:num_zarpe] + '/' + params[:anio_zarpe])
    else
      gabarra.analisis = Ensayo.find_by_bax_id_and_gabarra_id(gabarra.bax_id, gabarra.gabarra_id)
      
      # Formato a tipo de muestra
      case gabarra.analisis.muestreo
        when 'M'
          gabarra.analisis.muestreo = 'Manual'
        when 'A'
          gabarra.analisis.muestreo = 'Automático'
        else
          gabarra.analisis.muestreo = 'No disponible'
      end
      
      # Formato a procedencia del mineral
      case gabarra.analisis.tipo_carga
        when 'J'
          gabarra.analisis.tipo_carga = 'Pila Jobal'
        when 'B'
          gabarra.analisis.tipo_carga = 'Bypass'
        when 'A'
          gabarra.analisis.tipo_carga = 'Pila Jobal y Bypass'
        else
          gabarra.analisis.tipo_carga = 'No disponible'
      end
      

      # Verifico si el arribo existe y el estatus de la gabarra (navegando, atracada, descargando o vacía)
      # arribo = ArriboBauxita.find_by_bax_id(gabarra.bax_id)
      
      # unless arribo.nil?
      #   descarga = DescargaBauxita.find_by_arribo_id_and_gabarra_id(arribo.id, gabarra.gabarra_id)

      #   unless descarga.nil? # A menos que la descarga no exista
      #     if descarga.desatraque_descarga_bauxita || descarga.fin_descarga_bauxita # La gabarra ya ha sido desatracada o descargada 
      #       gabarra.status_img = 'thumb_up.png'
      #       logger.debug 'Gabarra descargada'
      #     elseif descarga.inicio_descarga_bauxita # La gabarra ya ha iniciado el proceso de descarga 
      #       gabarra.status_img = 'arrow_rotate_clockwise.png'
      #       logger.debug 'Gabarra en proceso'
      #     elseif descarga.atraque_descarga_bauxita # La gabarra ya ha sido atracada 
      #       gabarra.status_img = 'anchor.png'
      #       logger.debug 'Gabarra atracada'
      #     else # La gabarra está navegando, o esperando para ser atracada 
      #       gabarra.status_img = 'steering_wheel.png'
      #       logger.debug 'Gabarra esperando atracar'
      #     end
      #   else
      #     gabarra.status_img = 'peak_cap.png'
      #     logger.debug 'Gabarra navegando 1 '
      #   end
      # else
      #   gabarra.status_img = 'peak_cap.png'
      #   logger.debug 'Gabarra navegando 2'
      # end
      
      # Traigo las grúas de descarga
      gabarra.equipos = Equipo.find_all_by_tipo_equipo_id(1)
      
      return gabarra
    end    
  end
  
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
