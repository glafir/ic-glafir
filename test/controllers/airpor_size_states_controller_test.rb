require 'test_helper'

class AirporSizeStatesControllerTest < ActionController::TestCase
  setup do
    @airpor_size_state = airpor_size_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airpor_size_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create airpor_size_state" do
    assert_difference('AirporSizeState.count') do
      post :create, airpor_size_state: { name: @airpor_size_state.name }
    end

    assert_redirected_to airpor_size_state_path(assigns(:airpor_size_state))
  end

  test "should show airpor_size_state" do
    get :show, id: @airpor_size_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @airpor_size_state
    assert_response :success
  end

  test "should update airpor_size_state" do
    patch :update, id: @airpor_size_state, airpor_size_state: { name: @airpor_size_state.name }
    assert_redirected_to airpor_size_state_path(assigns(:airpor_size_state))
  end

  test "should destroy airpor_size_state" do
    assert_difference('AirporSizeState.count', -1) do
      delete :destroy, id: @airpor_size_state
    end

    assert_redirected_to airpor_size_states_path
  end
end
