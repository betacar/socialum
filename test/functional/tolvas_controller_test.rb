require 'test_helper'

class TolvasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tolvas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tolva" do
    assert_difference('Tolva.count') do
      post :create, :tolva => { }
    end

    assert_redirected_to tolva_path(assigns(:tolva))
  end

  test "should show tolva" do
    get :show, :id => tolvas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tolvas(:one).to_param
    assert_response :success
  end

  test "should update tolva" do
    put :update, :id => tolvas(:one).to_param, :tolva => { }
    assert_redirected_to tolva_path(assigns(:tolva))
  end

  test "should destroy tolva" do
    assert_difference('Tolva.count', -1) do
      delete :destroy, :id => tolvas(:one).to_param
    end

    assert_redirected_to tolvas_path
  end
end
