class Equipo < ActiveRecord::Base
  belongs_to :tipo_equipo
  stampable

  validates_associated :tipo_equipo
end
