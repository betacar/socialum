require 'test_helper'

class RolUsuariosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rol_usuarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rol_usuario" do
    assert_difference('RolUsuario.count') do
      post :create, :rol_usuario => { }
    end

    assert_redirected_to rol_usuario_path(assigns(:rol_usuario))
  end

  test "should show rol_usuario" do
    get :show, :id => rol_usuarios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => rol_usuarios(:one).to_param
    assert_response :success
  end

  test "should update rol_usuario" do
    put :update, :id => rol_usuarios(:one).to_param, :rol_usuario => { }
    assert_redirected_to rol_usuario_path(assigns(:rol_usuario))
  end

  test "should destroy rol_usuario" do
    assert_difference('RolUsuario.count', -1) do
      delete :destroy, :id => rol_usuarios(:one).to_param
    end

    assert_redirected_to rol_usuarios_path
  end
end
