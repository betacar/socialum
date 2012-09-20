require 'test_helper'

class RolTest < ActiveSupport::TestCase
  # No debe guardar registros en blanco
  test 'should not be blank' do
    rol = Rol.new
    assert !rol.save, 'Se inserto una tupla vacia'
  end

  # Debe poseer nombre
  test 'rol should have a name' do
    rol = Rol.new(:name => nil)
    assert !rol.save, 'Almaceno el rol sin nombre'
  end

  # Debe almacenar un rol
  test 'should save a rol' do
    rol = Rol.new(:name => 'Operador')
    assert rol.save, 'No almaceno el rol'
  end

  # Debe actualizar un rol
  test 'should update a rol' do
    rol = Rol.last
    rol.update_attribute(:name, 'Supervisor')

    assert_equal rol.name, 'Supervisor', 'No actualizo el nombre del rol'
  end
end
