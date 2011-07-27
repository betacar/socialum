class ArriboBauxita < ActiveRecord::Base
  set_table_name 'arribos_bauxita'
  belongs_to :transporte
  has_many :DescargaBauxitas, :as => :arribo
end
