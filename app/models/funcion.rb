class Funcion < ActiveRecord::Base
  set_table_name "funciones"
  has_and_belongs_to_many :rol
end
