class EmpresaTransporte < ActiveRecord::Base
  set_table_name 'vw_empresas_transportistas'
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
