require 'test_helper'

class AirportTerminalGatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airport_terminal_gate = airport_terminal_gates(:one)
  end

  test "should get index" do
    get airport_terminal_gates_url
    assert_response :success
  end

  test "should get new" do
    get new_airport_terminal_gate_url
    assert_response :success
  end

  test "should create airport_terminal_gate" do
    assert_difference('AirportTerminalGate.count') do
      post airport_terminal_gates_url, params: { airport_terminal_gate: { airport_terminal_id: @airport_terminal_gate.airport_terminal_id, gate: @airport_terminal_gate.gate } }
    end

    assert_redirected_to airport_terminal_gate_url(AirportTerminalGate.last)
  end

  test "should show airport_terminal_gate" do
    get airport_terminal_gate_url(@airport_terminal_gate)
    assert_response :success
  end

  test "should get edit" do
    get edit_airport_terminal_gate_url(@airport_terminal_gate)
    assert_response :success
  end

  test "should update airport_terminal_gate" do
    patch airport_terminal_gate_url(@airport_terminal_gate), params: { airport_terminal_gate: { airport_terminal_id: @airport_terminal_gate.airport_terminal_id, gate: @airport_terminal_gate.gate } }
    assert_redirected_to airport_terminal_gate_url(@airport_terminal_gate)
  end

  test "should destroy airport_terminal_gate" do
    assert_difference('AirportTerminalGate.count', -1) do
      delete airport_terminal_gate_url(@airport_terminal_gate)
    end

    assert_redirected_to airport_terminal_gates_url
  end
end
