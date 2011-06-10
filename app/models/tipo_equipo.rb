class TipoEquipo < ActiveRecord::Base
  set_table_name "tipos_equipos"
  belongs_to :estado
end
