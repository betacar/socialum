class TipoEquipo < ActiveRecord::Base
  set_table_name "tipos_equipos"
  
  # Guarda nuevos tipos de equipos
  def self.guardar(params)
    tipo_equipo = TipoEquipo.new(params)
      
    if tipo_equipo.save
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(tipo_equipo.errors)
    end
  end
  
  # Actualiza tipo equipo existente, a través del ID
  def self.actualizar(params)
    tipo_equipo = TipoEquipo.find(params[:id])
    
    if tipo_equipo.update_attributes(params[:tipo_equipo])
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(tipo_equipo.errors)
    end    
  end
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  def self.modificar_estado(id)
    tipo_equipo = TipoEquipo.find(id)
       
    if (tipo_equipo.estado_id == 2)
      tipo_equipo.update_attribute(:estado_id, 1)
    else
      tipo_equipo.update_attribute(:estado_id, 2)
    end
  end
end
