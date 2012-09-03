class Remolcador < ActiveRecord::Base
  self.table_name = :vw_remolcadores
  self.primary_key = :id
  has_many :baxs
  belongs_to :empresa_maritima, :foreign_key => :empresa_maritima_id

  # Se define como de solo lectura por ser una vista de BD
  protected
    def readonly?
      true
    end
end
