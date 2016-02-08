require 'test_helper'

class AirportStatesControllerTest < ActionController::TestCase
  setup do
    @airport_state = airport_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airport_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create airport_state" do
    assert_difference('AirportState.count') do
      post :create, airport_state: { name: @airport_state.name }
    end

    assert_redirected_to airport_state_path(assigns(:airport_state))
  end

  test "should show airport_state" do
    get :show, id: @airport_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @airport_state
    assert_response :success
  end

  test "should update airport_state" do
    patch :update, id: @airport_state, airport_state: { name: @airport_state.name }
    assert_redirected_to airport_state_path(assigns(:airport_state))
  end

  test "should destroy airport_state" do
    assert_difference('AirportState.count', -1) do
      delete :destroy, id: @airport_state
    end

    assert_redirected_to airport_states_path
  end
end
