class Remolcador < ActiveRecord::Base
  self.table_name = 'vw_remolcadores'
  self.primary_key = :id
  has_many :Baxs, :foreign_key => :remolcador_id
  
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
