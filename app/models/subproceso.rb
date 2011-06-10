class Subproceso < ActiveRecord::Base
  belongs_to :estado
  belongs_to :proceso
end
