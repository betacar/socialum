require 'test_helper'

class EstatusGabarrasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estatus_gabarras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estatus_gabarra" do
    assert_difference('EstatusGabarra.count') do
      post :create, :estatus_gabarra => { }
    end

    assert_redirected_to estatus_gabarra_path(assigns(:estatus_gabarra))
  end

  test "should show estatus_gabarra" do
    get :show, :id => estatus_gabarras(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => estatus_gabarras(:one).to_param
    assert_response :success
  end

  test "should update estatus_gabarra" do
    put :update, :id => estatus_gabarras(:one).to_param, :estatus_gabarra => { }
    assert_redirected_to estatus_gabarra_path(assigns(:estatus_gabarra))
  end

  test "should destroy estatus_gabarra" do
    assert_difference('EstatusGabarra.count', -1) do
      delete :destroy, :id => estatus_gabarras(:one).to_param
    end

    assert_redirected_to estatus_gabarras_path
  end
end
