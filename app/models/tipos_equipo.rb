class TiposEquipo < ActiveRecord::Base
  has_many :equipos
  stampable

  attr_accessible :nombre_tipo_equipo

  validates_presence_of :nombre_tipo_equipo, :message => 'Debe indicar el nombre del tipo de equipo'
end
