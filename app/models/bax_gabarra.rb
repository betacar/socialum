class BaxGabarra < ActiveRecord::Base
  set_table_name 'vw_zarpes_gabarras'
  belongs_to :bax
  has_one :DescargaBauxita
  attr_accessor :analisis, :equipos, :status_img, :descarga_id, :atraque_fecha, :atraque_hora, :inicio_fecha, :inicio_hora, :fin_fecha, :fin_hora, :desatraque_fecha, :desatraque_hora, :equipo_id, :novedades, :arribo # Atributos virtuales para almacenar los analisis de laboratorio y los equipos de descarga
  
  # Retorna los datos relativos a una gabarra de un BAX, para ser descargada
  def self.gabarra(params)
    gabarra = self.find_by_bax_id_and_gabarra_id(params[:num_zarpe] + '/' + params[:anio_zarpe], params[:gabarra_id])
    gabarra.arribo = ArriboBauxita.find_by_bax_id(params[:num_zarpe] + '/' + params[:anio_zarpe]).fecha_hora_arribo_bauxita.to_s(:db)
    
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
      arribo = ArriboBauxita.find_by_bax_id(gabarra.bax_id)
      descarga = DescargaBauxita.find_by_arribo_id_and_gabarra_id(arribo.id, gabarra.gabarra_id)

      unless descarga.nil? # A menos que la descarga no exista
        gabarra.descarga_id = descarga ? descarga.id : nil
        gabarra.atraque_fecha = descarga.atraque_descarga_bauxita ? descarga.atraque_descarga_bauxita.to_s(:fecha) : nil
        gabarra.atraque_hora = descarga.atraque_descarga_bauxita ? descarga.atraque_descarga_bauxita.to_s(:hora) : nil

        gabarra.inicio_fecha = descarga.inicio_descarga_bauxita ? descarga.inicio_descarga_bauxita.to_s(:fecha) : nil
        gabarra.inicio_hora = descarga.inicio_descarga_bauxita ? descarga.inicio_descarga_bauxita.to_s(:hora) : nil

        gabarra.fin_fecha = descarga.fin_descarga_bauxita ? descarga.fin_descarga_bauxita.to_s(:fecha) : nil
        gabarra.fin_hora = descarga.fin_descarga_bauxita ? descarga.fin_descarga_bauxita.to_s(:hora) : nil

        gabarra.desatraque_fecha = descarga.desatraque_descarga_bauxita ? descarga.desatraque_descarga_bauxita.to_s(:fecha) : nil
        gabarra.desatraque_hora = descarga.desatraque_descarga_bauxita ? descarga.desatraque_descarga_bauxita.to_s(:hora) : nil

        gabarra.equipo_id = descarga.equipo_id ? descarga.equipo_id : nil

        # Extraigo las novedades
        gabarra.novedades = gabarra.atraque_fecha ? Novedad.find_all_by_proceso_id_and_proceso_type(descarga.id, 'DescargaBauxita') : nil
      end
      
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
