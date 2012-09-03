class Novedad < ActiveRecord::Base
  belongs_to :proceso, :polymorphic => true
  belongs_to :tipo_novedad
  belongs_to :user, :foreign_key => :creator_id
  stampable
  validates_presence_of :desc_novedad, :inicio_novedad, :fin_novedad, :message => 'Los campos no pueden estar vacios'

  attr_accessible :proceso_id, :proceso_type, :tipo_novedad_id, :inicio_novedad, :fin_novedad, :desc_novedad

  default_scope order('inicio_novedad DESC')
end
