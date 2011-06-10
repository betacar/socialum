require 'test_helper'

class PatiosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patio" do
    assert_difference('Patio.count') do
      post :create, :patio => { }
    end

    assert_redirected_to patio_path(assigns(:patio))
  end

  test "should show patio" do
    get :show, :id => patios(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => patios(:one).to_param
    assert_response :success
  end

  test "should update patio" do
    put :update, :id => patios(:one).to_param, :patio => { }
    assert_redirected_to patio_path(assigns(:patio))
  end

  test "should destroy patio" do
    assert_difference('Patio.count', -1) do
      delete :destroy, :id => patios(:one).to_param
    end

    assert_redirected_to patios_path
  end
end
