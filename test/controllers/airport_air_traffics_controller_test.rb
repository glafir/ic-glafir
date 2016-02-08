require 'test_helper'

class AirportAirTrafficsControllerTest < ActionController::TestCase
  setup do
    @airport_air_traffic = airport_air_traffics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airport_air_traffics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create airport_air_traffic" do
    assert_difference('AirportAirTraffic.count') do
      post :create, airport_air_traffic: { klass: @airport_air_traffic.klass, name: @airport_air_traffic.name }
    end

    assert_redirected_to airport_air_traffic_path(assigns(:airport_air_traffic))
  end

  test "should show airport_air_traffic" do
    get :show, id: @airport_air_traffic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @airport_air_traffic
    assert_response :success
  end

  test "should update airport_air_traffic" do
    patch :update, id: @airport_air_traffic, airport_air_traffic: { klass: @airport_air_traffic.klass, name: @airport_air_traffic.name }
    assert_redirected_to airport_air_traffic_path(assigns(:airport_air_traffic))
  end

  test "should destroy airport_air_traffic" do
    assert_difference('AirportAirTraffic.count', -1) do
      delete :destroy, id: @airport_air_traffic
    end

    assert_redirected_to airport_air_traffics_path
  end
end
