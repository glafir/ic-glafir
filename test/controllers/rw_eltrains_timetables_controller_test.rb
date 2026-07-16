require "test_helper"

class RwEltrainsTimetablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rw_eltrains_timetable = rw_eltrains_timetables(:one)
  end

  test "should get index" do
    get rw_eltrains_timetables_url
    assert_response :success
  end

  test "should get new" do
    get new_rw_eltrains_timetable_url
    assert_response :success
  end

  test "should create rw_eltrains_timetable" do
    assert_difference('RwEltrainsTimetable.count') do
      post rw_eltrains_timetables_url, params: { rw_eltrains_timetable: { direction: @rw_eltrains_timetable.direction, station_id: @rw_eltrains_timetable.station_id, time_finish: @rw_eltrains_timetable.time_finish, time_start: @rw_eltrains_timetable.time_start, w0: @rw_eltrains_timetable.w0, w1: @rw_eltrains_timetable.w1, w2: @rw_eltrains_timetable.w2, w3: @rw_eltrains_timetable.w3, w4: @rw_eltrains_timetable.w4, w5: @rw_eltrains_timetable.w5, w6: @rw_eltrains_timetable.w6 } }
    end

    assert_redirected_to rw_eltrains_timetable_url(RwEltrainsTimetable.last)
  end

  test "should show rw_eltrains_timetable" do
    get rw_eltrains_timetable_url(@rw_eltrains_timetable)
    assert_response :success
  end

  test "should get edit" do
    get edit_rw_eltrains_timetable_url(@rw_eltrains_timetable)
    assert_response :success
  end

  test "should update rw_eltrains_timetable" do
    patch rw_eltrains_timetable_url(@rw_eltrains_timetable), params: { rw_eltrains_timetable: { direction: @rw_eltrains_timetable.direction, station_id: @rw_eltrains_timetable.station_id, time_finish: @rw_eltrains_timetable.time_finish, time_start: @rw_eltrains_timetable.time_start, w0: @rw_eltrains_timetable.w0, w1: @rw_eltrains_timetable.w1, w2: @rw_eltrains_timetable.w2, w3: @rw_eltrains_timetable.w3, w4: @rw_eltrains_timetable.w4, w5: @rw_eltrains_timetable.w5, w6: @rw_eltrains_timetable.w6 } }
    assert_redirected_to rw_eltrains_timetable_url(@rw_eltrains_timetable)
  end

  test "should destroy rw_eltrains_timetable" do
    assert_difference('RwEltrainsTimetable.count', -1) do
      delete rw_eltrains_timetable_url(@rw_eltrains_timetable)
    end

    assert_redirected_to rw_eltrains_timetables_url
  end
end
