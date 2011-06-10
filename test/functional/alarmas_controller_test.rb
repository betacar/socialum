require 'test_helper'

class AlarmasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alarmas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alarma" do
    assert_difference('Alarma.count') do
      post :create, :alarma => { }
    end

    assert_redirected_to alarma_path(assigns(:alarma))
  end

  test "should show alarma" do
    get :show, :id => alarmas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => alarmas(:one).to_param
    assert_response :success
  end

  test "should update alarma" do
    put :update, :id => alarmas(:one).to_param, :alarma => { }
    assert_redirected_to alarma_path(assigns(:alarma))
  end

  test "should destroy alarma" do
    assert_difference('Alarma.count', -1) do
      delete :destroy, :id => alarmas(:one).to_param
    end

    assert_redirected_to alarmas_path
  end
end
