class StockGabarra < ActiveRecord::Base
  belongs_to :locacion
  belongs_to :estatus_gabarra
  stampable
end
