require 'test_helper'

class SubprocesosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subprocesos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subproceso" do
    assert_difference('Subproceso.count') do
      post :create, :subproceso => { }
    end

    assert_redirected_to subproceso_path(assigns(:subproceso))
  end

  test "should show subproceso" do
    get :show, :id => subprocesos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => subprocesos(:one).to_param
    assert_response :success
  end

  test "should update subproceso" do
    put :update, :id => subprocesos(:one).to_param, :subproceso => { }
    assert_redirected_to subproceso_path(assigns(:subproceso))
  end

  test "should destroy subproceso" do
    assert_difference('Subproceso.count', -1) do
      delete :destroy, :id => subprocesos(:one).to_param
    end

    assert_redirected_to subprocesos_path
  end
end
