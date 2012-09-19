class Equipo < ActiveRecord::Base
  belongs_to :tipos_equipo
  stampable

  attr_accessible :nombre_equipo, :tipo_equipo_id

  validates_presence_of :nombre_equipo, :message => 'Debe indicar el nombre del equipo'
  validates_presence_of :tipo_equipo_id, :message => 'Debe indicar el tipo de equipo'
  validates_associated :tipos_equipo
end
