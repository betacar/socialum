class ArriboBauxita < ActiveRecord::Base
  set_table_name 'arribos_bauxita'
  belongs_to :remolcador
  has_many :DescargaBauxitas, :as => :arribo
  has_one :bax
  
  # Se dispara al reportar el arribo de un BAX. 
  # Copia los datos del BAX de Pijigüaos a Matanzas
  def self.arribo(params)
    arribo = self.find_by_bax_id(params[:num_zarpe] + '/' + params[:ano_zarpe])
    
    if !arribo.nil?
      raise Exceptions::PresenciaValoresExcepcion.new('El arribo ya fue reportado')
    else
      zarpe = Bax.find(params[:num_zarpe] + '/' + params[:ano_zarpe])
            
      arribo = self.new
      arribo.bax_id = zarpe.id # Numero de BAX
      arribo.capitan_arribo_bauxita = zarpe.nombre_capitan.titleize # Nombre del capitán
      arribo.tonelaje_arribo_bauxita = zarpe.carga_transportar # Tonelaje transportado
      arribo.fecha_hora_arribo_bauxita = DateTime.now # Fecha y hora de arribo
      arribo.usuario_id_created = params[:usuario_id_created] # Usuario que creo el registro
      
      if arribo.save
        true
      else
        raise Exceptions::PresenciaValoresExcepcion.new(arribo.errors)
      end
    end
  end
end
