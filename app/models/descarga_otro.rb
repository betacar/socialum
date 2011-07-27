class DescargaOtro < ActiveRecord::Base
  set_table_name 'descargas_otros'
  belongs_to :arribo_buque
end
