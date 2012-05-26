class Gabarra < ActiveRecord::Base
  self.table_name = 'vw_gabarras'
  self.primary_key = :id

  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
