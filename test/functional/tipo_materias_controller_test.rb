require 'test_helper'

class TipoMateriasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_materias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_materia" do
    assert_difference('TipoMateria.count') do
      post :create, :tipo_materia => { }
    end

    assert_redirected_to tipo_materia_path(assigns(:tipo_materia))
  end

  test "should show tipo_materia" do
    get :show, :id => tipo_materias(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tipo_materias(:one).to_param
    assert_response :success
  end

  test "should update tipo_materia" do
    put :update, :id => tipo_materias(:one).to_param, :tipo_materia => { }
    assert_redirected_to tipo_materia_path(assigns(:tipo_materia))
  end

  test "should destroy tipo_materia" do
    assert_difference('TipoMateria.count', -1) do
      delete :destroy, :id => tipo_materias(:one).to_param
    end

    assert_redirected_to tipo_materias_path
  end
end
