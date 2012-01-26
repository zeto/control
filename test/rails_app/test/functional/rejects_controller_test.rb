require 'test_helper'

class RejectsControllerTest < ActionController::TestCase
  setup do
    @reject = rejects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rejects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reject" do
    assert_difference('Reject.count') do
      post :create, reject: @reject.attributes
    end

    assert_redirected_to reject_path(assigns(:reject))
  end

  test "should show reject" do
    get :show, id: @reject
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reject
    assert_response :success
  end

  test "should update reject" do
    put :update, id: @reject, reject: @reject.attributes
    assert_redirected_to reject_path(assigns(:reject))
  end

  test "should destroy reject" do
    assert_difference('Reject.count', -1) do
      delete :destroy, id: @reject
    end

    assert_redirected_to rejects_path
  end
end
