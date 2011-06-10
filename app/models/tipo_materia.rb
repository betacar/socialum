class TipoMateria < ActiveRecord::Base
  set_table_name "tipos_materiales"
  belongs_to :estado
end
