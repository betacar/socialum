require 'test_helper'

class ProcesosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:procesos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proceso" do
    assert_difference('Proceso.count') do
      post :create, :proceso => { }
    end

    assert_redirected_to proceso_path(assigns(:proceso))
  end

  test "should show proceso" do
    get :show, :id => procesos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => procesos(:one).to_param
    assert_response :success
  end

  test "should update proceso" do
    put :update, :id => procesos(:one).to_param, :proceso => { }
    assert_redirected_to proceso_path(assigns(:proceso))
  end

  test "should destroy proceso" do
    assert_difference('Proceso.count', -1) do
      delete :destroy, :id => procesos(:one).to_param
    end

    assert_redirected_to procesos_path
  end
end
