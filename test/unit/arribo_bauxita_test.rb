require 'test_helper'

class ArriboBauxitaTest < ActiveSupport::TestCase
  # No debe guardar registros en blanco
  test 'should not be blank' do
    arribo = ArriboBauxita.new
    assert !arribo.save, 'Se inserto un registro vacio'
  end

  # No debe guardar un BAX duplicado
  test 'should not save duplicated BAX' do
    a = ArriboBauxita.find_by_bax_id('001-2012')

    arribo = ArriboBauxita.new({:bax_id => a.bax_id, :fecha_hora_arribo_bauxita => a.fecha_hora_arribo_bauxita})
    assert !arribo.save, 'Se almaceno un BAX duplicado'
  end

  # La fecha no puede ser mayor a ahora
  test 'date should not be after now' do
    arribo = ArriboBauxita.new({:bax_id => '001-2012', :fecha_hora_arribo_bauxita => DateTime.now + 1.year})
    assert !arribo.save, 'La fecha de arribo es mayor a ahora (arribo futuro)'
  end

  # BAX_ID no puede ser vacio
  test 'bax_id should not be blank' do
    arribo = ArriboBauxita.new({:bax_id => '', :fecha_hora_arribo_bauxita => DateTime.now})
    assert !arribo.save, 'El ID del BAX es vacio'
  end

  # Fecha de arribo no puede ser vacia
  test 'fecha_hora_arribo_bauxita should not be blank' do
    arribo = ArriboBauxita.new({:bax_id => '001-2012', :fecha_hora_arribo_bauxita => ''})
    assert !arribo.save, 'La fecha de arribo es vacia'
  end

  # No debe almacenar un BAX con formato incorrecto
  test 'should not save BAX with not correct format' do
    arribo = ArriboBauxita.new({:bax_id => 'ABC-DEFG', :fecha_hora_arribo_bauxita => DateTime.now})
    assert !arribo.save, 'El ID del BAX se almaceno con un formato incorrecto'
  end

  # descargado debe ser falso al insertar el BAX
  test 'descargado should be false' do
    arribo = ArriboBauxita.new({:bax_id => '001-2012', :fecha_hora_arribo_bauxita => DateTime.now})
    arribo.save
    assert !arribo.descargado, 'El estado de descarga es true'
  end

  # Al actualizar descargado, debe ser verdadero
  test 'descargado should be true on update' do
    arribo = ArriboBauxita.new({:bax_id => '001-2012', :fecha_hora_arribo_bauxita => DateTime.now})
    arribo.save

    arribado = ArriboBauxita.find_by_bax_id('001-2012')
    arribado.toggle(:descargado)
    assert arribado.descargado, 'El atributo descargado es verdadero'
  end
end
