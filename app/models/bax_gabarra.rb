class BaxGabarra < ActiveRecord::Base
  self.table_name = :vw_baxs_gabarras

  belongs_to :bax, :foreign_key => :bax_id
  belongs_to :gabarra, :foreign_key => :gabarra_id
  has_one :arribo_bauxita, :through => :bax
  has_one :descarga_bauxita, :through => :arribo_bauxita

  def self.find(bax_id, gabarra_id = nil)
    if gabarra_id.nil?
      find_all_by_bax_id(bax_id)
    else
      find_by_bax_id_and_gabarra_id(bax_id, gabarra_id)
    end
  end

  # Se define como de solo lectura por ser una vista de BD
  protected
    def readonly?
      true
    end
end
