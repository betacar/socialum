class Empleado < ActiveRecord::Base
  set_table_name 'vw_personal'
  has_one :user
    
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
