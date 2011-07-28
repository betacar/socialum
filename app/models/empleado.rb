class Empleado < ActiveRecord::Base
  set_table_name 'vw_personal'
  set_primary_key 'numero_personal'
  has_one :usuario, :foreign_key => :id
    
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
