class EmpresaTransporte < ActiveRecord::Base
  self.table_name = 'vw_empresas_transportistas'
  self.primary_key = :id
  has_many :Baxs, :foreign_key => :empresa_transporte_id
  
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
