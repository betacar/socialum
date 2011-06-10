require 'test_helper'

class PuntoTolvasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:punto_tolvas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create punto_tolva" do
    assert_difference('PuntoTolva.count') do
      post :create, :punto_tolva => { }
    end

    assert_redirected_to punto_tolva_path(assigns(:punto_tolva))
  end

  test "should show punto_tolva" do
    get :show, :id => punto_tolvas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => punto_tolvas(:one).to_param
    assert_response :success
  end

  test "should update punto_tolva" do
    put :update, :id => punto_tolvas(:one).to_param, :punto_tolva => { }
    assert_redirected_to punto_tolva_path(assigns(:punto_tolva))
  end

  test "should destroy punto_tolva" do
    assert_difference('PuntoTolva.count', -1) do
      delete :destroy, :id => punto_tolvas(:one).to_param
    end

    assert_redirected_to punto_tolvas_path
  end
end
