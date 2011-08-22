class Equipo < ActiveRecord::Base
  belongs_to :tipo_equipo
  belongs_to :subproceso
  belongs_to :empresa
  stampable
end
