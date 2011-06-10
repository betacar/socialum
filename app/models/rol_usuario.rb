class RolUsuario < ActiveRecord::Base
  belongs_to :estado
  belongs_to :rol
  belongs_to :usuario
end
