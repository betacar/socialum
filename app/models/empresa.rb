class Empresa < ActiveRecord::Base
  belongs_to :estado
  validates_presence_of :estado_id, :nombre_empresa, :pais_empresa
  validates_associated :estado
end
