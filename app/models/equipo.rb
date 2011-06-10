class Equipo < ActiveRecord::Base
  belongs_to :estado
  belongs_to :tipo_equipo
  belongs_to :subproceso
  belongs_to :empresa
  has_and_belongs_to_many :meta
  validates_presence_of :estado_id, :tipo_equipo_id, :empresa_id, :nombre_equipo
end
