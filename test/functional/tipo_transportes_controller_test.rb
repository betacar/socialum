require 'test_helper'

class TipoTransportesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_transportes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_transporte" do
    assert_difference('TipoTransporte.count') do
      post :create, :tipo_transporte => { }
    end

    assert_redirected_to tipo_transporte_path(assigns(:tipo_transporte))
  end

  test "should show tipo_transporte" do
    get :show, :id => tipo_transportes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tipo_transportes(:one).to_param
    assert_response :success
  end

  test "should update tipo_transporte" do
    put :update, :id => tipo_transportes(:one).to_param, :tipo_transporte => { }
    assert_redirected_to tipo_transporte_path(assigns(:tipo_transporte))
  end

  test "should destroy tipo_transporte" do
    assert_difference('TipoTransporte.count', -1) do
      delete :destroy, :id => tipo_transportes(:one).to_param
    end

    assert_redirected_to tipo_transportes_path
  end
end
