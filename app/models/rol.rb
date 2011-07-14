class Rol < ActiveRecord::Base
  set_table_name "roles"
  has_and_belongs_to_many :funcion
end
