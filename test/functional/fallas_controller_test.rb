require 'test_helper'

class FallasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fallas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create falla" do
    assert_difference('Falla.count') do
      post :create, :falla => { }
    end

    assert_redirected_to falla_path(assigns(:falla))
  end

  test "should show falla" do
    get :show, :id => fallas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fallas(:one).to_param
    assert_response :success
  end

  test "should update falla" do
    put :update, :id => fallas(:one).to_param, :falla => { }
    assert_redirected_to falla_path(assigns(:falla))
  end

  test "should destroy falla" do
    assert_difference('Falla.count', -1) do
      delete :destroy, :id => fallas(:one).to_param
    end

    assert_redirected_to fallas_path
  end
end
