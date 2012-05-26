class Locacion < ActiveRecord::Base
  self.table_name = 'locaciones'
  stampable
  
  # Guarda nuevas locaciones
  def self.guardar(params)
    locacion = Locacion.new(params)
      
    if locacion.save
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(locacion.errors)
    end
  end
  
  # Actualiza locaciones existente, a través del ID
  def self.actualizar(params)
    locacion = Locacion.find(params[:id])
    
    if locacion.update_attributes(params[:locacion])
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(locacion.errors)
    end    
  end
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  def self.modificar_estado(id)
    locacion = Locacion.find(id)
       
    if (!locacion.activo)
      locacion.update_attribute(:activo, true)
    else
      locacion.update_attribute(:activo, false)
    end
  end
end