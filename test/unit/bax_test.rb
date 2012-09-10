require 'test_helper'

class BaxTest < ActiveSupport::TestCase
  # No debe poder salvar nuevos registros, por ser DB view
  test "should not save BAX" do
    bax = Bax.new
    assert !bax.save
  end
end
