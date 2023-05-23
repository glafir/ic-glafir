require "test_helper"

class StationPrioritiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @station_priority = station_priorities(:one)
  end

  test "should get index" do
    get station_priorities_url
    assert_response :success
  end

  test "should get new" do
    get new_station_priority_url
    assert_response :success
  end

  test "should create station_priority" do
    assert_difference('StationPriority.count') do
      post station_priorities_url, params: { station_priority: { priority: @station_priority.priority, rw_route_id: @station_priority.rw_route_id, station_id: @station_priority.station_id } }
    end

    assert_redirected_to station_priority_url(StationPriority.last)
  end

  test "should show station_priority" do
    get station_priority_url(@station_priority)
    assert_response :success
  end

  test "should get edit" do
    get edit_station_priority_url(@station_priority)
    assert_response :success
  end

  test "should update station_priority" do
    patch station_priority_url(@station_priority), params: { station_priority: { priority: @station_priority.priority, rw_route_id: @station_priority.rw_route_id, station_id: @station_priority.station_id } }
    assert_redirected_to station_priority_url(@station_priority)
  end

  test "should destroy station_priority" do
    assert_difference('StationPriority.count', -1) do
      delete station_priority_url(@station_priority)
    end

    assert_redirected_to station_priorities_url
  end
end
