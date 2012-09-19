class ArriboBauxita < ActiveRecord::Base
  self.table_name = :arribos_bauxita
  
  belongs_to :bax
  belongs_to :bax_gabarra
  has_many :descarga_bauxitas, :as => :arribo, :dependent => :destroy

  stampable

  attr_accessible :bax_id, :fecha_hora_arribo_bauxita, :descargado

  validates :bax_id, :fecha_hora_arribo_bauxita, :presence => true
  validates_uniqueness_of :bax_id, 
                          :message => 'El BAX ya ha sido reportado.'
  validates :bax_id, :format => { :with => /\d{3,4}-?/, 
                     :message => 'El ID del BAX debe cumplir el formato establecido.' }
  validates :fecha_hora_arribo_bauxita, 
            :date => { :before_or_equal_to => Proc.new { Time.now } }

  validates_associated :bax
  validates_associated :bax_gabarra
end
