class Alarma < ActiveRecord::Base
  belongs_to :estado
  validates_presence_of :nombre_alarma, :message => "El nombre de la alarma no puede estar vacío"
  validates_presence_of :usuario_id_updated, :on => :update
  validates_associated :estado
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  def self.modificar_estado(id)
    @alarma = self.find(id)
       
    if (@alarma.estado_id == 2)
      @alarma.update_attribute(:estado_id, 1)
    else
      @alarma.update_attribute(:estado_id, 2)
    end
  end
  
  def self.guardar(params)
    alarma = Alarma.new(params)
      
    if alarma.save
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(alarma.errors)
    end
  end
end
