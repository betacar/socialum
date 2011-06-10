class Locacion < ActiveRecord::Base
  set_table_name "locaciones"
  belongs_to :estado
end
