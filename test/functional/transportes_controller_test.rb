require 'test_helper'

class TransportesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transportes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transporte" do
    assert_difference('Transporte.count') do
      post :create, :transporte => { }
    end

    assert_redirected_to transporte_path(assigns(:transporte))
  end

  test "should show transporte" do
    get :show, :id => transportes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => transportes(:one).to_param
    assert_response :success
  end

  test "should update transporte" do
    put :update, :id => transportes(:one).to_param, :transporte => { }
    assert_redirected_to transporte_path(assigns(:transporte))
  end

  test "should destroy transporte" do
    assert_difference('Transporte.count', -1) do
      delete :destroy, :id => transportes(:one).to_param
    end

    assert_redirected_to transportes_path
  end
end
