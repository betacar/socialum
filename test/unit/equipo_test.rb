require 'test_helper'

class EquipoTest < ActiveSupport::TestCase
  # No debe guardar registros en blanco
  test 'should not be blank' do
    equipo = Equipo.new
    assert !equipo.save, 'Se inserto una tupla vacia'
  end

  # Debe poseer nombre
  test 'equipo should have a nombre' do
    equipo = Equipo.new({:nombre_equipo => nil, :tipo_equipo_id => TiposEquipo.first.id})
    assert !equipo.save, 'Almaceno el equipo sin nombre'
  end

  # Debe almacenar un equipo
  test 'equipo should have a tipo equipo' do
    equipo = Equipo.new({:nombre_equipo => 'Grua', :tipo_equipo_id => nil})
    assert !equipo.save, 'Almaceno el equipo sin tipo'
  end

  # Debe almacenar un equipo
  test 'tipo equipo must exist' do
    t_equipo = Equipo.first.tipo_equipo_id
    assert_equal TiposEquipo.find(t_equipo).id, t_equipo, 'El tipo de equipo no existe'
  end

  # Debe almacenar un equipo
  test 'should save a equipo' do
    equipo = Equipo.new({:nombre_equipo => 'Grua', :tipo_equipo_id => TiposEquipo.first.id})
    assert equipo.save, 'No almaceno el equipo'
  end

  # Debe almacenar un equipo
  test 'should update a equipo' do
    equipo = Equipo.last
    equipo.update_attribute(:nombre_equipo, 'Cisterna')

    assert_equal equipo.nombre_equipo, 'Cisterna', 'No actualizo el nombre del equipo'
  end
end
