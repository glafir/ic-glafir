require 'test_helper'

class AirportDistancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airport_distance = airport_distances(:one)
  end

  test "should get index" do
    get airport_distances_url
    assert_response :success
  end

  test "should get new" do
    get new_airport_distance_url
    assert_response :success
  end

  test "should create airport_distance" do
    assert_difference('AirportDistance.count') do
      post airport_distances_url, params: { airport_distance: { airport_finish_id: @airport_distance.airport_finish_id, airport_start_id: @airport_distance.airport_start_id, distance: @airport_distance.distance } }
    end

    assert_redirected_to airport_distance_url(AirportDistance.last)
  end

  test "should show airport_distance" do
    get airport_distance_url(@airport_distance)
    assert_response :success
  end

  test "should get edit" do
    get edit_airport_distance_url(@airport_distance)
    assert_response :success
  end

  test "should update airport_distance" do
    patch airport_distance_url(@airport_distance), params: { airport_distance: { airport_finish_id: @airport_distance.airport_finish_id, airport_start_id: @airport_distance.airport_start_id, distance: @airport_distance.distance } }
    assert_redirected_to airport_distance_url(@airport_distance)
  end

  test "should destroy airport_distance" do
    assert_difference('AirportDistance.count', -1) do
      delete airport_distance_url(@airport_distance)
    end

    assert_redirected_to airport_distances_url
  end
end
