# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Semilla de estados por defecto
# 30021061: Carlos Betancourt C.
estados = Estado.create([{:desc_estado => 'Activo', :usuario_id_created => 30021061, :usuario_id_updated => 30021061}, {:desc_estado => 'Inactivo', :usuario_id_created => 30021061, :usuario_id_updated => 30021061}])
