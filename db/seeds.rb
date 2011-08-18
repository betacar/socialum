# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Semilla de tuplas por defecto
# 30021061: Carlos Betancourt C.

#tipo_equipo = TiposEquipo.create([{:nombre_tipo_equipo => 'Grúa de descarga', :usuario_id_created => 30021061, :usuario_id_updated => nil}])

#equipos = Equipo.create([{:tipo_equipo_id => tipo_equipo.id, :nombre_equipo => 'GMS-1', :usuario_id_created => 30021061}, {:tipo_equipo_id => tipo_equipo.id, :nombre_equipo => 'GMS-2', :usuario_id_created => 30021061}, {:tipo_equipo_id => tipo_equipo.id, :nombre_equipo => 'SU16-1', :usuario_id_created => 30021061}, {:tipo_equipo_id => tipo_equipo.id, :nombre_equipo => 'SU16-2', :usuario_id_created => 30021061}, {:tipo_equipo_id => tipo_equipo.id, :nombre_equipo => 'TPO', :usuario_id_created => 30021061}, {:tipo_equipo_id => tipo_equipo.id, :nombre_equipo => 'Otros', :usuario_id_created => 30021061}])

#locaciones = Locacion.create([{:nombre_locacion => 'Matanzas', :usuario_id_created => 30021061}, {:nombre_locacion => 'El Jobal', :usuario_id_created => 30021061}, {:nombre_locacion => 'Río arriba', :usuario_id_created => 30021061}, {:nombre_locacion => 'Río abajo', :usuario_id_created => 30021061}])
locacion = Locacion.create([{:nombre_locacion => 'Otro', :usuario_id_created => 30021061}])

#estatus_gabarras = EstatusGabarra.create([{:desc_estatus_gabarra => 'Cargadas', :usuario_id_created => 30021061}, {:desc_estatus_gabarra => 'En proceso', :usuario_id_created => 30021061}, {:desc_estatus_gabarra => 'Vacías', :usuario_id_created => 30021061}, {:desc_estatus_gabarra => 'En reparación', :usuario_id_created => 30021061}])

#patios = Patio.create([{:nombre_patio => 'PA3 - Derecho'}, {:nombre_patio => 'PA3 - Izquierdo'}, {:nombre_patio => 'Outdoor'}, {:nombre_patio => 'Indoor'}])

#tipos_materiales = TipoMateria.create([{:desc_tipo_materia => 'Bauxita'}, {:desc_tipo_materia => 'Alúmina'}, {:desc_tipo_materia => 'Caustica'}, {:desc_tipo_materia => 'Cal'}])

#silos = Silo.create([{:nombre_silo => '1'}, {:nombre_silo => '2'}, {:nombre_silo => '3'}, {:nombre_silo => '101'}, {:nombre_silo => '102'}])

#puntos_tolvas = PuntoTolva.create([{:desc_punto_tolva => 'A'}, {:desc_punto_tolva => 'B'}, {:desc_punto_tolva => 'C'}, {:desc_punto_tolva => 'D'}, {:desc_punto_tolva => 'E'}, {:desc_punto_tolva => 'F'}, {:desc_punto_tolva => 'G'}, {:desc_punto_tolva => 'H'}, {:desc_punto_tolva => 'J'}, {:desc_punto_tolva => 'K'}, {:desc_punto_tolva => 'L'}])

#tolvas = Tolva.create([{:desc_tolva => 'Este'}, {:desc_tolva => 'Centro'}, {:desc_tolva => 'Oeste'}])

#estados = Estado.create([{:desc_estado => 'Activo', :usuario_id_created => 30021061, :usuario_id_updated => 30021061}, 
#						 {:desc_estado => 'Inactivo', :usuario_id_created => 30021061, :usuario_id_updated => 30021061}])
