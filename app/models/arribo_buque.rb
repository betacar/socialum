class ArriboBuque < ActiveRecord::Base
  set_table_name 'arribos_buques'
  belongs_to :tipo_materia
  has_many :DescargaBauxitas, :as => :arribo
  stampable
end
