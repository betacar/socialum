class Empleado < ActiveRecord::Base
  self.table_name = :vw_personal
  has_one :user

  def nombre_completo
    [self.nombres, self.apellidos].join(' ').titleize
  end
    
  # Se define como de solo lectura por ser una vista de BD
  protected
    def readonly?
      true
    end
end
