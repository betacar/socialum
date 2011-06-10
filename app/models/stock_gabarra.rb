class StockGabarra < ActiveRecord::Base
  belongs_to :estado
  belongs_to :locacion
  belongs_to :estatus_gabarra
end
