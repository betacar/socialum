require 'test_helper'

class StockGabarrasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_gabarras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_gabarra" do
    assert_difference('StockGabarra.count') do
      post :create, :stock_gabarra => { }
    end

    assert_redirected_to stock_gabarra_path(assigns(:stock_gabarra))
  end

  test "should show stock_gabarra" do
    get :show, :id => stock_gabarras(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stock_gabarras(:one).to_param
    assert_response :success
  end

  test "should update stock_gabarra" do
    put :update, :id => stock_gabarras(:one).to_param, :stock_gabarra => { }
    assert_redirected_to stock_gabarra_path(assigns(:stock_gabarra))
  end

  test "should destroy stock_gabarra" do
    assert_difference('StockGabarra.count', -1) do
      delete :destroy, :id => stock_gabarras(:one).to_param
    end

    assert_redirected_to stock_gabarras_path
  end
end
