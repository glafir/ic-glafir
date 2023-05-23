require "application_system_test_case"

class StationPrioritiesTest < ApplicationSystemTestCase
  setup do
    @station_priority = station_priorities(:one)
  end

  test "visiting the index" do
    visit station_priorities_url
    assert_selector "h1", text: "Station Priorities"
  end

  test "creating a Station priority" do
    visit station_priorities_url
    click_on "New Station Priority"

    fill_in "Priority", with: @station_priority.priority
    fill_in "Rw route", with: @station_priority.rw_route_id
    fill_in "Station", with: @station_priority.station_id
    click_on "Create Station priority"

    assert_text "Station priority was successfully created"
    click_on "Back"
  end

  test "updating a Station priority" do
    visit station_priorities_url
    click_on "Edit", match: :first

    fill_in "Priority", with: @station_priority.priority
    fill_in "Rw route", with: @station_priority.rw_route_id
    fill_in "Station", with: @station_priority.station_id
    click_on "Update Station priority"

    assert_text "Station priority was successfully updated"
    click_on "Back"
  end

  test "destroying a Station priority" do
    visit station_priorities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Station priority was successfully destroyed"
  end
end
