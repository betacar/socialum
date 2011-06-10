class Meta < ActiveRecord::Base
  belongs_to :estado
  belongs_to :subproceso
  has_and_belongs_to_many :equipo
end
