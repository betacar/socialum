require 'test_helper'

class LocacionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create locacion" do
    assert_difference('Locacion.count') do
      post :create, :locacion => { }
    end

    assert_redirected_to locacion_path(assigns(:locacion))
  end

  test "should show locacion" do
    get :show, :id => locacions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => locacions(:one).to_param
    assert_response :success
  end

  test "should update locacion" do
    put :update, :id => locacions(:one).to_param, :locacion => { }
    assert_redirected_to locacion_path(assigns(:locacion))
  end

  test "should destroy locacion" do
    assert_difference('Locacion.count', -1) do
      delete :destroy, :id => locacions(:one).to_param
    end

    assert_redirected_to locacions_path
  end
end
