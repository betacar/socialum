require 'test_helper'

class DescargaBauxitaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test 'unloads should not be blank' do
    descarga = DescargaBauxita.new
    assert !descarga.save, 'Descarga vacia'
  end

  # La descarga debe poseer una gabarra
  test 'unload should have a gabarra' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :tonelaje_descarga_bauxita => 1234.56, 
            :equipo_id => Equipo.first.id, 
            :atraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:07' },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }

    descarga = DescargaBauxita.new(data)
    assert !descarga.save, 'Descarga no posee gabarra'
  end

  # La descarga debe poseer un arribo
  test 'unload should have a arribo' do
    data = {  :gabarra_id => 'ACBL-123', 
            :tonelaje_descarga_bauxita => 1234.56, 
            :equipo_id => Equipo.first.id, 
            :atraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:07' },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }

    descarga = DescargaBauxita.new(data)
    assert !descarga.save, 'Descarga no posee arribo'
  end

  # La descarga debe poseer una fecha y hora de atraque
  test 'unload should have a atraque' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => 'ACBL-123', 
            :tonelaje_descarga_bauxita => 1234.56, 
            :equipo_id => Equipo.first.id, 
            :atraque_descarga_bauxita => { :fecha => nil, :hora => nil },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }

    descarga = DescargaBauxita.new(data)
    assert !descarga.save, 'Descarga no posee fecha y hora de atraque'
  end

  # La descarga debe poseer un equipo de descarga
  test 'unload should have a equipo' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => 'ACBL-123', 
            :tonelaje_descarga_bauxita => 1234.56, 
            :atraque_descarga_bauxita => { :fecha => nil, :hora => nil },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }

    descarga = DescargaBauxita.new(data)
    assert !descarga.save, 'Descarga no posee un equipo de descarga'
  end

  # La descarga debe poseer el tonelaje de la gabarra
  test 'unload should have a tonelaje of gabarra' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => 'ACBL-123', 
            :equipo_id => Equipo.first.id, 
            :atraque_descarga_bauxita => { :fecha => nil, :hora => nil },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }

    descarga = DescargaBauxita.new(data)
    assert !descarga.save, 'Descarga no posee el tonelaje de la gabarra'
  end

  # No debe guardar un BAX duplicado
  test 'should not save duplicated unloads' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => 'ACBL-123', 
            :tonelaje_descarga_bauxita => 1234.56, 
            :equipo_id => Equipo.first.id, 
            :atraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:07' },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }
    a = DescargaBauxita.new(data)
    a.save

    b = DescargaBauxita.new(data)
    assert !b.save, 'Descarga duplicada'
  end

  # El ID de la gabarra debe poseer el formato correcto
  test 'gabarra ID should have the right format' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => '1A2B-3C4', 
            :tonelaje_descarga_bauxita => 1234.56, 
            :equipo_id => Equipo.first.id,
            :atraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:07' },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }

    d = DescargaBauxita.new(data)
    assert !d.save, 'Acepto el formato incorrecto'
  end

  # El tonelaje de la gabarra debe poseer el formato correcto
  test 'tonelaje should have the right format' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => 'ACBL-123', 
            :tonelaje_descarga_bauxita => 'ACBD.0R', 
            :equipo_id => Equipo.first.id,
            :atraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:07' },
            :inicio_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:10' },
            :fin_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:11' },
            :desatraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:13' }
          }

    d = DescargaBauxita.new(data)
    assert !d.save, 'Acepto el formato incorrecto'
  end

  # Debe poder almacenar datos con solo los atributos requeridos
  test 'should save with required attributes' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => 'ACBL-123', 
            :tonelaje_descarga_bauxita => 1234.56, 
            :equipo_id => Equipo.first.id,
            :atraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:07' },
            :inicio_descarga_bauxita => { :fecha => nil, :hora => nil },
            :fin_descarga_bauxita => { :fecha => nil, :hora => nil },
            :desatraque_descarga_bauxita => { :fecha => nil, :hora => nil }
          }

    d = DescargaBauxita.new(data)
    assert d.save, 'No acepta atributos minimos'
  end

  # Debe poder almacenar datos con solo los atributos requeridos
  test 'should update the datetime attributes' do
    data = { :arribo_id => ArriboBauxita.first.id, 
            :gabarra_id => 'ACBL-123', 
            :tonelaje_descarga_bauxita => 1234.56, 
            :equipo_id => Equipo.first.id,
            :atraque_descarga_bauxita => { :fecha => '26/07/2011', :hora => '14:07' },
            :inicio_descarga_bauxita => { :fecha => nil, :hora => nil },
            :fin_descarga_bauxita => { :fecha => nil, :hora => nil },
            :desatraque_descarga_bauxita => { :fecha => nil, :hora => nil }
          }

    d = DescargaBauxita.new(data)
    d.save

    d.update_attribute(:inicio_descarga_bauxita, '2011-07-26 14:10')

    assert_equal d.inicio_descarga_bauxita.to_s, '2011-07-26 14:10:00 -0430', 'No actualizo en attributo'
  end

  # El metodo gabarra debe retorna la data de descarga de una gabarra
  test 'should return a gabarra unload' do
    g = DescargaBauxita.last
    descarga = DescargaBauxita.find_by_arribo_id(g.arribo_id).gabarra(g.gabarra_id)

    assert_equal g, descarga, 'Restorna un objeto diferente'
  end
end
