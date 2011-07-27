class DescargaBauxita < ActiveRecord::Base
  set_table_name 'descargas_bauxita'
  belongs_to :arribo, :polymorphic => true
  belongs_to :equipo
end
