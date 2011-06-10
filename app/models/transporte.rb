class Transporte < ActiveRecord::Base
  belongs_to :estado
  belongs_to :tipo_transporte
  belongs_to :empresa
end
