require "application_system_test_case"

class RwEltrainsTimetablesTest < ApplicationSystemTestCase
  setup do
    @rw_eltrains_timetable = rw_eltrains_timetables(:one)
  end

  test "visiting the index" do
    visit rw_eltrains_timetables_url
    assert_selector "h1", text: "Rw Eltrains Timetables"
  end

  test "creating a Rw eltrains timetable" do
    visit rw_eltrains_timetables_url
    click_on "New Rw Eltrains Timetable"

    fill_in "Direction", with: @rw_eltrains_timetable.direction
    fill_in "Station", with: @rw_eltrains_timetable.station_id
    fill_in "Time finish", with: @rw_eltrains_timetable.time_finish
    fill_in "Time start", with: @rw_eltrains_timetable.time_start
    fill_in "W0", with: @rw_eltrains_timetable.w0
    fill_in "W1", with: @rw_eltrains_timetable.w1
    fill_in "W2", with: @rw_eltrains_timetable.w2
    fill_in "W3", with: @rw_eltrains_timetable.w3
    fill_in "W4", with: @rw_eltrains_timetable.w4
    fill_in "W5", with: @rw_eltrains_timetable.w5
    fill_in "W6", with: @rw_eltrains_timetable.w6
    click_on "Create Rw eltrains timetable"

    assert_text "Rw eltrains timetable was successfully created"
    click_on "Back"
  end

  test "updating a Rw eltrains timetable" do
    visit rw_eltrains_timetables_url
    click_on "Edit", match: :first

    fill_in "Direction", with: @rw_eltrains_timetable.direction
    fill_in "Station", with: @rw_eltrains_timetable.station_id
    fill_in "Time finish", with: @rw_eltrains_timetable.time_finish
    fill_in "Time start", with: @rw_eltrains_timetable.time_start
    fill_in "W0", with: @rw_eltrains_timetable.w0
    fill_in "W1", with: @rw_eltrains_timetable.w1
    fill_in "W2", with: @rw_eltrains_timetable.w2
    fill_in "W3", with: @rw_eltrains_timetable.w3
    fill_in "W4", with: @rw_eltrains_timetable.w4
    fill_in "W5", with: @rw_eltrains_timetable.w5
    fill_in "W6", with: @rw_eltrains_timetable.w6
    click_on "Update Rw eltrains timetable"

    assert_text "Rw eltrains timetable was successfully updated"
    click_on "Back"
  end

  test "destroying a Rw eltrains timetable" do
    visit rw_eltrains_timetables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rw eltrains timetable was successfully destroyed"
  end
end
