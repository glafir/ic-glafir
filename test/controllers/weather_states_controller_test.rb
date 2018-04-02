require 'test_helper'

class WeatherStatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_state = weather_states(:one)
  end

  test "should get index" do
    get weather_states_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_state_url
    assert_response :success
  end

  test "should create weather_state" do
    assert_difference('WeatherState.count') do
      post weather_states_url, params: { weather_state: { description: @weather_state.description, icon: @weather_state.icon, main: @weather_state.main, weather_id: @weather_state.weather_id } }
    end

    assert_redirected_to weather_state_url(WeatherState.last)
  end

  test "should show weather_state" do
    get weather_state_url(@weather_state)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather_state_url(@weather_state)
    assert_response :success
  end

  test "should update weather_state" do
    patch weather_state_url(@weather_state), params: { weather_state: { description: @weather_state.description, icon: @weather_state.icon, main: @weather_state.main, weather_id: @weather_state.weather_id } }
    assert_redirected_to weather_state_url(@weather_state)
  end

  test "should destroy weather_state" do
    assert_difference('WeatherState.count', -1) do
      delete weather_state_url(@weather_state)
    end

    assert_redirected_to weather_states_url
  end
end
