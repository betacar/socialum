class Empleado < ActiveRecord::Base
  set_table_name 'vw_personal'
  set_primary_key 'numero_personal'
  has_one :usuario, :foreign_key => :id
  
  def self.getDatosSolicitud(ficha)
    empleado = nil 
    Empleado.find(ficha, :where => ['fecha_egreso' == nil]) # Devuelvo todos los datos del empleado, siempre y cuando no tenga fecha de egreso
  end 
end
