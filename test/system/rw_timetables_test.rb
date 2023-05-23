require "application_system_test_case"

class RwTimetablesTest < ApplicationSystemTestCase
  setup do
    @rw_timetable = rw_timetables(:one)
  end

  test "visiting the index" do
    visit rw_timetables_url
    assert_selector "h1", text: "Rw Timetables"
  end

  test "creating a Rw timetable" do
    visit rw_timetables_url
    click_on "New Rw Timetable"

    fill_in "Station", with: @rw_timetable.station_id
    fill_in "Time arr", with: @rw_timetable.time_arr
    fill_in "Time dep", with: @rw_timetable.time_dep
    fill_in "Train", with: @rw_timetable.train_id
    click_on "Create Rw timetable"

    assert_text "Rw timetable was successfully created"
    click_on "Back"
  end

  test "updating a Rw timetable" do
    visit rw_timetables_url
    click_on "Edit", match: :first

    fill_in "Station", with: @rw_timetable.station_id
    fill_in "Time arr", with: @rw_timetable.time_arr
    fill_in "Time dep", with: @rw_timetable.time_dep
    fill_in "Train", with: @rw_timetable.train_id
    click_on "Update Rw timetable"

    assert_text "Rw timetable was successfully updated"
    click_on "Back"
  end

  test "destroying a Rw timetable" do
    visit rw_timetables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rw timetable was successfully destroyed"
  end
end
