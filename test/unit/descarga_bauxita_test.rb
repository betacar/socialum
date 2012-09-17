require 'test_helper'

class DescargaBauxitaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test 'unloads should not be blank' do
    descarga = DescargaBauxita.new
    assert !descarga.save, 'La descarga es vacia'
  end
end
