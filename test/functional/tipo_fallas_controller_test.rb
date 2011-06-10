require 'test_helper'

class TipoFallasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_fallas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_falla" do
    assert_difference('TipoFalla.count') do
      post :create, :tipo_falla => { }
    end

    assert_redirected_to tipo_falla_path(assigns(:tipo_falla))
  end

  test "should show tipo_falla" do
    get :show, :id => tipo_fallas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tipo_fallas(:one).to_param
    assert_response :success
  end

  test "should update tipo_falla" do
    put :update, :id => tipo_fallas(:one).to_param, :tipo_falla => { }
    assert_redirected_to tipo_falla_path(assigns(:tipo_falla))
  end

  test "should destroy tipo_falla" do
    assert_difference('TipoFalla.count', -1) do
      delete :destroy, :id => tipo_fallas(:one).to_param
    end

    assert_redirected_to tipo_fallas_path
  end
end
