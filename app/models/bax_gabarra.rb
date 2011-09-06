class BaxGabarra < ActiveRecord::Base
  set_table_name 'vw_zarpes_gabarras'
  belongs_to :bax
  has_one :DescargaBauxita
  attr_accessor :analisis, :equipos, :status_img, :descarga_id, :atraque_fecha, :atraque_hora, :inicio_fecha, :inicio_hora, :fin_fecha, :fin_hora, :desatraque_fecha, :desatraque_hora, :equipo_id, :novedades, :arribo # Atributos virtuales para almacenar los analisis de laboratorio y los equipos de descarga
  
  def self.gabarras(id)
    bax = Bax.find(id)
    gabarras = bax.BaxGabarras

    unless bax.ArriboBauxita.nil? 
      i = 0
        
      gabarras.each do |gabarra|
        descarga = DescargaBauxita.find_by_arribo_id_and_gabarra_id(bax.ArriboBauxita.id, gabarra.gabarra_id)

        # Si, el código adyacente es un desastre. Pero funciona.
        unless descarga.nil? 
          if !descarga.desatraque_descarga_bauxita.nil? # La gabarra ya ha sido desatracada 
            gabarras[i].status_img = 'flag_finish.png'
          elsif !descarga.fin_descarga_bauxita.nil? # La gabarra ya ha sido descargada 
            gabarras[i].status_img = 'tick.png'
          elsif !descarga.inicio_descarga_bauxita.nil? # La gabarra ya ha iniciado el proceso de descarga 
            gabarras[i].status_img = 'arrow_rotate_clockwise.png'
          elsif !descarga.atraque_descarga_bauxita.nil? # La gabarra ya ha sido atracada 
            gabarras[i].status_img = 'anchor.png'
          else # La gabarra está a la espera para atracar
            gabarras[i].status_img = 'clock_red.png'
          end
        else
          gabarras[i].status_img = 'clock_red.png' # La gabarra está a la espera para atracar
        end

        i = i.next
      end

    else
      i = 0

      gabarras.each do |gabarra| # El BAX aún no ha sido reportado como que arribó a Matanzas
        gabarras[i].status_img = 'steering_wheel.png'
        i = i.next
      end
    end

    gabarras
  end

  # Retorna los datos relativos a una gabarra de un BAX, para ser descargada
  def self.gabarra(params)
    gabarra = self.find_by_bax_id_and_gabarra_id(params[:num_zarpe] + '/' + params[:anio_zarpe], params[:gabarra_id])
    gabarra.arribo = ArriboBauxita.find_by_bax_id(params[:num_zarpe] + '/' + params[:anio_zarpe]).fecha_hora_arribo_bauxita
    
    if gabarra.nil?
      raise Exceptions::PresenciaValoresExcepcion.new('La gabarra ' + params[:gabarra_id] + ' no está asociada al BAX ' + params[:num_zarpe] + '/' + params[:anio_zarpe])
    else
     
      # Formato a tipo de muestra
      case gabarra.muestreo
        when 'M'
          gabarra.muestreo = 'Manual'
        when 'A'
          gabarra.muestreo = 'Automático'
        else
          gabarra.muestreo = 'No disponible'
      end
      
      # Formato a procedencia del mineral
      case gabarra.tipo_carga
        when 'J'
          gabarra.tipo_carga = 'Pila Jobal'
        when 'B'
          gabarra.tipo_carga = 'Bypass'
        when 'A'
          gabarra.tipo_carga = 'Pila Jobal y Bypass'
        else
          gabarra.tipo_carga = 'No disponible'
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
