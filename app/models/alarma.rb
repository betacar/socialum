class Alarma < ActiveRecord::Base
  belongs_to :estado
  validates_presence_of :nombre_alarma, :message => "El campo no puede ser nulo"
  validates_presence_of :usuario_id_updated, :on => :update
  validates_associated :estado
  attr_accessible :ficha # Accedo a la ficha del current_usuario
  
  def before_update 
    self.usuario_id_updated = ficha
  end
end
