require 'test_helper'

class AirportTerminalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airport_terminal = airport_terminals(:one)
  end

  test "should get index" do
    get airport_terminals_url
    assert_response :success
  end

  test "should get new" do
    get new_airport_terminal_url
    assert_response :success
  end

  test "should create airport_terminal" do
    assert_difference('AirportTerminal.count') do
      post airport_terminals_url, params: { airport_terminal: { airport_id: @airport_terminal.airport_id, terminal: @airport_terminal.terminal } }
    end

    assert_redirected_to airport_terminal_url(AirportTerminal.last)
  end

  test "should show airport_terminal" do
    get airport_terminal_url(@airport_terminal)
    assert_response :success
  end

  test "should get edit" do
    get edit_airport_terminal_url(@airport_terminal)
    assert_response :success
  end

  test "should update airport_terminal" do
    patch airport_terminal_url(@airport_terminal), params: { airport_terminal: { airport_id: @airport_terminal.airport_id, terminal: @airport_terminal.terminal } }
    assert_redirected_to airport_terminal_url(@airport_terminal)
  end

  test "should destroy airport_terminal" do
    assert_difference('AirportTerminal.count', -1) do
      delete airport_terminal_url(@airport_terminal)
    end

    assert_redirected_to airport_terminals_url
  end
end
