require 'test_helper'

class TerminalsControllerTest < ActionController::TestCase
  setup do
    @terminal = terminals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:terminals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create terminal" do
    assert_difference('Terminal.count') do
      post :create, terminal: { airport_id: @terminal.airport_id, area: @terminal.area, floor: @terminal.floor, gate: @terminal.gate, marking: @terminal.marking, name: @terminal.name, parking: @terminal.parking, reception: @terminal.reception, teletrap: @terminal.teletrap }
    end

    assert_redirected_to terminal_path(assigns(:terminal))
  end

  test "should show terminal" do
    get :show, id: @terminal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @terminal
    assert_response :success
  end

  test "should update terminal" do
    patch :update, id: @terminal, terminal: { airport_id: @terminal.airport_id, area: @terminal.area, floor: @terminal.floor, gate: @terminal.gate, marking: @terminal.marking, name: @terminal.name, parking: @terminal.parking, reception: @terminal.reception, teletrap: @terminal.teletrap }
    assert_redirected_to terminal_path(assigns(:terminal))
  end

  test "should destroy terminal" do
    assert_difference('Terminal.count', -1) do
      delete :destroy, id: @terminal
    end

    assert_redirected_to terminals_path
  end
end
