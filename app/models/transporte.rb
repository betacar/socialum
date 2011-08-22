class Transporte < ActiveRecord::Base
  belongs_to :tipo_transporte
  stampable
end
