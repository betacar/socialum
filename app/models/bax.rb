class Bax < ActiveRecord::Base
  set_table_name 'vw_zarpes_bax'
  set_primary_key 'id'
  has_many :BaxGabarras
  has_many :Ensayos
  
  # Se define como de solo lectura por ser una vista de BD
  protected
    def after_initialize
      readonly!
    end
    
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end
end
