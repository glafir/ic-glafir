require "application_system_test_case"

class RwEltrainsRoutesTest < ApplicationSystemTestCase
  setup do
    @rw_eltrains_route = rw_eltrains_routes(:one)
  end

  test "visiting the index" do
    visit rw_eltrains_routes_url
    assert_selector "h1", text: "Rw Eltrains Routes"
  end

  test "creating a Rw eltrains route" do
    visit rw_eltrains_routes_url
    click_on "New Rw Eltrains Route"

    fill_in "Priority direct", with: @rw_eltrains_route.priority_direct
    fill_in "Station", with: @rw_eltrains_route.station_id
    click_on "Create Rw eltrains route"

    assert_text "Rw eltrains route was successfully created"
    click_on "Back"
  end

  test "updating a Rw eltrains route" do
    visit rw_eltrains_routes_url
    click_on "Edit", match: :first

    fill_in "Priority direct", with: @rw_eltrains_route.priority_direct
    fill_in "Station", with: @rw_eltrains_route.station_id
    click_on "Update Rw eltrains route"

    assert_text "Rw eltrains route was successfully updated"
    click_on "Back"
  end

  test "destroying a Rw eltrains route" do
    visit rw_eltrains_routes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rw eltrains route was successfully destroyed"
  end
end
