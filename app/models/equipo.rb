class Equipo < ActiveRecord::Base
  belongs_to :tipo_equipo
  stampable
end
