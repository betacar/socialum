class EmpresaMaritima < ActiveRecord::Base
  self.table_name = :vw_empresas_maritimas
  self.primary_key = :id

  has_many :baxs
  has_many :remolcadores
  has_many :gabarras
  
  # Se define como de solo lectura por ser una vista de BD
  protected
    def readonly?
      true
    end
end