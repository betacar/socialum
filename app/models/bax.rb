class Bax < ActiveRecord::Base
  # Por no cumplir con la convención de Rails,
  # se definen la entidad y clave primaria de BD
  self.table_name  = :vw_bax
  self.primary_key = :id

  # Relación con otros modelos
  belongs_to :remolcador, :foreign_key => :remolcador_id
  belongs_to :empresa_maritima, :foreign_key => :empresa_maritima_id
  has_one    :arribo_bauxita, :foreign_key => :bax_id
  has_many   :bax_gabarras
  has_many   :gabarras, :through => :bax_gabarras
  has_many   :descarga_bauxitas, :through => :arribo_bauxita

  scope :embarques, includes(:remolcador, :empresa_maritima, { :arribo_bauxita => [:descarga_bauxitas] }) 
    
  # Se define como de solo lectura por ser una vista de BD
  protected
    def readonly? 
      true
    end
end
