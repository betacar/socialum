class Alarma < ActiveRecord::Base
  belongs_to :estado
  validates_presence_of :nombre_alarma, :message => "El campo no puede ser nulo"
  validates_presence_of :usuario_id_updated, :on => :update
  validates_associated :estado
  attr_accessible :ficha # Accedo a la ficha del current_usuario
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  def self.modificar_estado(id)
    @alarma = self.find(id)
       
    if (@alarma.estado_id == 2)
      @alarma.update_attribute(:estado_id, 1)
    else
      @alarma.update_attribute(:estado_id, 2)
    end
  end
end
