class EstatusGabarra < ActiveRecord::Base
  belongs_to :estado
  validates_presence_of :desc_estatus_gabarra
  validates_associated :estado
end
