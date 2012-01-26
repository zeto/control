require 'test_helper'

class ValidatesControllerTest < ActionController::TestCase
  setup do
    @validate = validates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:validates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create validate" do
    assert_difference('Validate.count') do
      post :create, validate: @validate.attributes
    end

    assert_redirected_to validate_path(assigns(:validate))
  end

  test "should show validate" do
    get :show, id: @validate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @validate
    assert_response :success
  end

  test "should update validate" do
    put :update, id: @validate, validate: @validate.attributes
    assert_redirected_to validate_path(assigns(:validate))
  end

  test "should destroy validate" do
    assert_difference('Validate.count', -1) do
      delete :destroy, id: @validate
    end

    assert_redirected_to validates_path
  end
end
