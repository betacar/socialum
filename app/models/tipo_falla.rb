class TipoFalla < ActiveRecord::Base
  set_table_name "tipos_fallas"
  belongs_to :estado
end
