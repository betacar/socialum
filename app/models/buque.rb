class Buque < ActiveRecord::Base
  belongs_to :tipo_material
  stampable
end
