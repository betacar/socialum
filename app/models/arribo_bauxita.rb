class ArriboBauxita < ActiveRecord::Base
  self.table_name = :arribos_bauxita
  
  belongs_to :bax
  belongs_to :bax_gabarra
  has_many :descarga_bauxitas, :as => :arribo, :dependent => :destroy

  stampable

  attr_accessible :bax_id, :fecha_hora_arribo_bauxita, :descargado

  validates_uniqueness_of :bax_id, :message => 'El BAX ya ha sido reportado.'
end
