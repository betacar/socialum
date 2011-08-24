class ArriboBauxita < ActiveRecord::Base
  set_table_name 'arribos_bauxita'
  belongs_to :remolcador
  has_many :DescargaBauxitas, :as => :arribo
  has_one :bax
  stampable
  
  # Se dispara al reportar el arribo de un BAX. 
  # Copia los datos del BAX de Pijigüaos a Matanzas
  def self.arribo(params)
    arribo = ArriboBauxita.find_by_bax_id(params[:num_zarpe] + '/' + params[:anio_zarpe])
    
    unless !arribo.nil?
      zarpe = Bax.find(params[:num_zarpe] + '/' + params[:anio_zarpe])
            
      arribo = self.new
      arribo.bax_id = zarpe.id                                        # Numero de BAX
      arribo.capitan_arribo_bauxita = zarpe.nombre_capitan.titleize   # Nombre del capitán
      arribo.tonelaje_arribo_bauxita = zarpe.carga_transportar        # Tonelaje transportado
      arribo.empresa_transporte_id = zarpe.empresa_transporte_id      # Empresa transportista
      arribo.fecha_hora_arribo_bauxita = DateTime.now                 # Fecha y hora de arribo
      
      if arribo.save
        true
      else
        raise Exceptions::PresenciaValoresExcepcion.new(arribo.errors)
      end
    else
      raise Exceptions::PresenciaValoresExcepcion.new('El arribo ya fue reportado')
    end
  end

  # Verifica si todo un arribo fue totalmente descargado
  # Actualiza el atributo 'descargado'
  def self.bax_descargado(arribo_id)
    arribo = self.find(arribo_id)
    gabarras = BaxGabarra.find_all_by_bax_id(arribo.bax_id)
    descargas = DescargaBauxita.find_all_by_arribo_id(arribo.id)

    if gabarras.size == descargas.size
      arribo.toggle!('descargado')
    end
  end
end
