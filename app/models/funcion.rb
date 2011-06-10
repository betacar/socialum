class Funcion < ActiveRecord::Base
  set_table_name "funciones"
  belongs_to :estado
  has_and_belongs_to_many :rol
end
