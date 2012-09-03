class TiposEquipo < ActiveRecord::Base
  has_many :equipos
  stampable
end
