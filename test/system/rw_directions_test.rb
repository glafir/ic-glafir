require "application_system_test_case"

class RwDirectionsTest < ApplicationSystemTestCase
  setup do
    @rw_direction = rw_directions(:one)
  end

  test "visiting the index" do
    visit rw_directions_url
    assert_selector "h1", text: "Rw Directions"
  end

  test "creating a Rw direction" do
    visit rw_directions_url
    click_on "New Rw Direction"

    fill_in "Direction station", with: @rw_direction.direction_station_id
    fill_in "Station", with: @rw_direction.station_id
    click_on "Create Rw direction"

    assert_text "Rw direction was successfully created"
    click_on "Back"
  end

  test "updating a Rw direction" do
    visit rw_directions_url
    click_on "Edit", match: :first

    fill_in "Direction station", with: @rw_direction.direction_station_id
    fill_in "Station", with: @rw_direction.station_id
    click_on "Update Rw direction"

    assert_text "Rw direction was successfully updated"
    click_on "Back"
  end

  test "destroying a Rw direction" do
    visit rw_directions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rw direction was successfully destroyed"
  end
end
