require 'test_helper'

class EquiposControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:equipos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipo" do
    assert_difference('Equipo.count') do
      post :create, :equipo => { }
    end

    assert_redirected_to equipo_path(assigns(:equipo))
  end

  test "should show equipo" do
    get :show, :id => equipos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => equipos(:one).to_param
    assert_response :success
  end

  test "should update equipo" do
    put :update, :id => equipos(:one).to_param, :equipo => { }
    assert_redirected_to equipo_path(assigns(:equipo))
  end

  test "should destroy equipo" do
    assert_difference('Equipo.count', -1) do
      delete :destroy, :id => equipos(:one).to_param
    end

    assert_redirected_to equipos_path
  end
end
