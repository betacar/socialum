require 'test_helper'

class TipoEquiposControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_equipos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_equipo" do
    assert_difference('TipoEquipo.count') do
      post :create, :tipo_equipo => { }
    end

    assert_redirected_to tipo_equipo_path(assigns(:tipo_equipo))
  end

  test "should show tipo_equipo" do
    get :show, :id => tipo_equipos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tipo_equipos(:one).to_param
    assert_response :success
  end

  test "should update tipo_equipo" do
    put :update, :id => tipo_equipos(:one).to_param, :tipo_equipo => { }
    assert_redirected_to tipo_equipo_path(assigns(:tipo_equipo))
  end

  test "should destroy tipo_equipo" do
    assert_difference('TipoEquipo.count', -1) do
      delete :destroy, :id => tipo_equipos(:one).to_param
    end

    assert_redirected_to tipo_equipos_path
  end
end
