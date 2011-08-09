class BaxGabarra < ActiveRecord::Base
  set_table_name 'vw_zarpes_gabarras'
  belongs_to :bax
  attr_accessor :analisis # Atributo virtual para almacenar los analisis de laboratorio
  
  # Retorna los datos relativos a una gabarra de un BAX, para ser descargada
  def self.gabarra(params)
    gabarra = self.find_by_bax_id_and_gabarra_id(params[:num_zarpe] + '/' + params[:anio_zarpe], params[:gabarra_id])
    
    if gabarra.nil?
      raise Exceptions::PresenciaValoresExcepcion.new('La gabarra ' + params[:gabarra_id] + ' no está asociada al BAX ' + params[:num_zarpe] + '/' + params[:anio_zarpe])
    else
      gabarra.analisis = Ensayo.find(gabarra.bax_id + '/' + gabarra.gabarra_id, :limit => 1)
      
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
