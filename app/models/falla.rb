class Falla < ActiveRecord::Base
  belongs_to :estado
  belongs_to :equipo
  belongs_to :alarma
  belongs_to :tipo_falla
  validates_presence_of :estado_id, :equipo_id, :alarma_id, :tipo_falla_id, :fecha_inicio_falla, :fecha_fin_falla, :observaciones_falla
  validates_associated :estado, :equipo, :alarma, :tipo_falla
  # TODO: Validar formato datetime
  #validates_format_of :fecha_inicio_falla, :fecha_fin_falla, :with => 
end
