class Empresa < ActiveRecord::Base
  belongs_to :estado
  validates_presence_of :estado_id, :pais_empresa, :responsable_empresa
  validates_presence_of :nombre_empresa, :message => 'El nombre de la empresa no puede estar vacío'
  validates_presence_of :usuario_id_updated, :on => :update
  validates_associated :estado
  
  # Guarda nuevas empresa
  def self.guardar(params)
    empresa = Empresa.new(params)
      
    if empresa.save
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(empresa.errors)
    end
  end
  
  # Actualiza empresas existente, a través del ID
  def self.actualizar(params)
    empresa = Empresa.find(params[:id])
    
    if empresa.update_attributes(params[:empresa])
      true
    else
      raise Exceptions::PresenciaValoresExcepcion.new(empresa.errors)
    end    
  end
  
  # Se cambia el estado de la tupla de Inactiva a Activa.
  def self.modificar_estado(id)
    empresa = Empresa.find(id)
       
    if (empresa.estado_id == 2)
      empresa.update_attribute(:estado_id, 1)
    else
      empresa.update_attribute(:estado_id, 2)
    end
  end
end
