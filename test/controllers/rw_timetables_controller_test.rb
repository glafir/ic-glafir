require "test_helper"

class RwTimetablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rw_timetable = rw_timetables(:one)
  end

  test "should get index" do
    get rw_timetables_url
    assert_response :success
  end

  test "should get new" do
    get new_rw_timetable_url
    assert_response :success
  end

  test "should create rw_timetable" do
    assert_difference('RwTimetable.count') do
      post rw_timetables_url, params: { rw_timetable: { station_id: @rw_timetable.station_id, time_arr: @rw_timetable.time_arr, time_dep: @rw_timetable.time_dep, train_id: @rw_timetable.train_id } }
    end

    assert_redirected_to rw_timetable_url(RwTimetable.last)
  end

  test "should show rw_timetable" do
    get rw_timetable_url(@rw_timetable)
    assert_response :success
  end

  test "should get edit" do
    get edit_rw_timetable_url(@rw_timetable)
    assert_response :success
  end

  test "should update rw_timetable" do
    patch rw_timetable_url(@rw_timetable), params: { rw_timetable: { station_id: @rw_timetable.station_id, time_arr: @rw_timetable.time_arr, time_dep: @rw_timetable.time_dep, train_id: @rw_timetable.train_id } }
    assert_redirected_to rw_timetable_url(@rw_timetable)
  end

  test "should destroy rw_timetable" do
    assert_difference('RwTimetable.count', -1) do
      delete rw_timetable_url(@rw_timetable)
    end

    assert_redirected_to rw_timetables_url
  end
end
