require 'test_helper'

class TiposEquipoTest < ActiveSupport::TestCase
  # No debe guardar registros en blanco
  test 'should not be blank' do
    tipo_equipo = TiposEquipo.new
    assert !tipo_equipo.save, 'Se inserto una tupla vacia'
  end

  # Debe poseer nombre
  test 'tipo equipo should have a nombre' do
    tipo_equipo = TiposEquipo.new(:nombre_tipo_equipo => nil)
    assert !tipo_equipo.save, 'Almaceno el equipo sin nombre'
  end

  # Debe almacenar un equipo
  test 'should save a tipo equipo' do
    tipo_equipo = TiposEquipo.new(:nombre_tipo_equipo => 'Grua')
    assert tipo_equipo.save, 'No almaceno el equipo'
  end

  # Debe almacenar un equipo
  test 'should update a tipo equipo' do
    tipo_equipo = TiposEquipo.last
    tipo_equipo.update_attribute(:nombre_tipo_equipo, 'Bomba hidraulica')

    assert_equal tipo_equipo.nombre_tipo_equipo, 'Bomba hidraulica', 'No actualizo el nombre del equipo'
  end
end
