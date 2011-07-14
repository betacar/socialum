class RolUsuario < ActiveRecord::Base
  belongs_to :rol
  belongs_to :usuario
end
