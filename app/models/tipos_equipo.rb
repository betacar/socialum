class TiposEquipo < ActiveRecord::Base
  has_many :equipos
  stampable

  validates_associated :equipo
end
