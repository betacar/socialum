class Subproceso < ActiveRecord::Base
  belongs_to :proceso
  stampable
end
