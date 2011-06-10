require 'test_helper'

class FuncionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:funcions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create funcion" do
    assert_difference('Funcion.count') do
      post :create, :funcion => { }
    end

    assert_redirected_to funcion_path(assigns(:funcion))
  end

  test "should show funcion" do
    get :show, :id => funcions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => funcions(:one).to_param
    assert_response :success
  end

  test "should update funcion" do
    put :update, :id => funcions(:one).to_param, :funcion => { }
    assert_redirected_to funcion_path(assigns(:funcion))
  end

  test "should destroy funcion" do
    assert_difference('Funcion.count', -1) do
      delete :destroy, :id => funcions(:one).to_param
    end

    assert_redirected_to funcions_path
  end
end
