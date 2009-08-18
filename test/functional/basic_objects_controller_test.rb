require 'test_helper'

class BasicObjectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:basic_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create basic_object" do
    assert_difference('BasicObject.count') do
      post :create, :basic_object => { }
    end

    assert_redirected_to basic_object_path(assigns(:basic_object))
  end

  test "should show basic_object" do
    get :show, :id => basic_objects(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => basic_objects(:one).to_param
    assert_response :success
  end

  test "should update basic_object" do
    put :update, :id => basic_objects(:one).to_param, :basic_object => { }
    assert_redirected_to basic_object_path(assigns(:basic_object))
  end

  test "should destroy basic_object" do
    assert_difference('BasicObject.count', -1) do
      delete :destroy, :id => basic_objects(:one).to_param
    end

    assert_redirected_to basic_objects_path
  end
end
