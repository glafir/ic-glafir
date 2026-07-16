require "test_helper"

class RwEltrainsRoutesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rw_eltrains_route = rw_eltrains_routes(:one)
  end

  test "should get index" do
    get rw_eltrains_routes_url
    assert_response :success
  end

  test "should get new" do
    get new_rw_eltrains_route_url
    assert_response :success
  end

  test "should create rw_eltrains_route" do
    assert_difference('RwEltrainsRoute.count') do
      post rw_eltrains_routes_url, params: { rw_eltrains_route: { priority_direct: @rw_eltrains_route.priority_direct, station_id: @rw_eltrains_route.station_id } }
    end

    assert_redirected_to rw_eltrains_route_url(RwEltrainsRoute.last)
  end

  test "should show rw_eltrains_route" do
    get rw_eltrains_route_url(@rw_eltrains_route)
    assert_response :success
  end

  test "should get edit" do
    get edit_rw_eltrains_route_url(@rw_eltrains_route)
    assert_response :success
  end

  test "should update rw_eltrains_route" do
    patch rw_eltrains_route_url(@rw_eltrains_route), params: { rw_eltrains_route: { priority_direct: @rw_eltrains_route.priority_direct, station_id: @rw_eltrains_route.station_id } }
    assert_redirected_to rw_eltrains_route_url(@rw_eltrains_route)
  end

  test "should destroy rw_eltrains_route" do
    assert_difference('RwEltrainsRoute.count', -1) do
      delete rw_eltrains_route_url(@rw_eltrains_route)
    end

    assert_redirected_to rw_eltrains_routes_url
  end
end
