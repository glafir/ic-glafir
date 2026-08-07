require "test_helper"

class RwDirectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rw_direction = rw_directions(:one)
  end

  test "should get index" do
    get rw_directions_url
    assert_response :success
  end

  test "should get new" do
    get new_rw_direction_url
    assert_response :success
  end

  test "should create rw_direction" do
    assert_difference('RwDirection.count') do
      post rw_directions_url, params: { rw_direction: { direction_station_id: @rw_direction.direction_station_id, station_id: @rw_direction.station_id } }
    end

    assert_redirected_to rw_direction_url(RwDirection.last)
  end

  test "should show rw_direction" do
    get rw_direction_url(@rw_direction)
    assert_response :success
  end

  test "should get edit" do
    get edit_rw_direction_url(@rw_direction)
    assert_response :success
  end

  test "should update rw_direction" do
    patch rw_direction_url(@rw_direction), params: { rw_direction: { direction_station_id: @rw_direction.direction_station_id, station_id: @rw_direction.station_id } }
    assert_redirected_to rw_direction_url(@rw_direction)
  end

  test "should destroy rw_direction" do
    assert_difference('RwDirection.count', -1) do
      delete rw_direction_url(@rw_direction)
    end

    assert_redirected_to rw_directions_url
  end
end
