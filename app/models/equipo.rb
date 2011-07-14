class Equipo < ActiveRecord::Base
  belongs_to :tipo_equipo
  belongs_to :subproceso
  belongs_to :empresa
  has_and_belongs_to_many :meta
  validates_presence_of :tipo_equipo_id, :empresa_id, :nombre_equipo
  
  # Guarda nuevos equipos
  def self.guardar(params)
    equipo = Equipo.new(params)
      
    if equipo.save
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(equipo.errors)
    end
  end
  
  # Actualiza equipo existente, a través del ID
  def self.actualizar(params)
    equipo = Equipo.find(params[:id])
    
    if equipo.update_attributes(params[:equipo])
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(equipo.errors)
    end    
  end
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  def self.modificar_estado(id)
    equipo = Equipo.find(id)
       
    if (equipo.estado_id == 2)
      equipo.update_attribute(:estado_id, 1)
    else
      equipo.update_attribute(:estado_id, 2)
    end
  end
end
