class Gabarra < ActiveRecord::Base
  self.table_name = :vw_gabarras
  self.primary_key = :id
  
  has_many :bax_gabarras
  has_many :baxs, :through => :bax_gabarras
  has_many :descarga_bauxitas
  belongs_to :empresa_maritima, :foreign_key => :empresa_maritima_id

  # Se define como de solo lectura por ser una vista de BD
  protected
    def readonly?
      true
    end
end
