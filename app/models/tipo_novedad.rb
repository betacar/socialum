class TipoNovedad < ActiveRecord::Base
  self.table_name = :tipo_novedades
  has_many :novedades
  stampable
end
