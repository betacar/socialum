class BaxGabarra < ActiveRecord::Base
  set_table_name 'vw_zarpes_gabarras'
  has_one :bax
  
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
