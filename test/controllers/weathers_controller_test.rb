require 'test_helper'

class WeathersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather = weathers(:one)
  end

  test "should get index" do
    get weathers_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_url
    assert_response :success
  end

  test "should create weather" do
    assert_difference('Weather.count') do
      post weathers_url, params: { weather: { clouds: @weather.clouds, dt: @weather.dt, place_id: @weather.place_id, pressure: @weather.pressure, pressure_grnd_level: @weather.pressure_grnd_level, pressure_sea_level: @weather.pressure_sea_level, temp: @weather.temp, temp_max: @weather.temp_max, temp_min: @weather.temp_min, wind_deg: @weather.wind_deg, wind_speed: @weather.wind_speed } }
    end

    assert_redirected_to weather_url(Weather.last)
  end

  test "should show weather" do
    get weather_url(@weather)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather_url(@weather)
    assert_response :success
  end

  test "should update weather" do
    patch weather_url(@weather), params: { weather: { clouds: @weather.clouds, dt: @weather.dt, place_id: @weather.place_id, pressure: @weather.pressure, pressure_grnd_level: @weather.pressure_grnd_level, pressure_sea_level: @weather.pressure_sea_level, temp: @weather.temp, temp_max: @weather.temp_max, temp_min: @weather.temp_min, wind_deg: @weather.wind_deg, wind_speed: @weather.wind_speed } }
    assert_redirected_to weather_url(@weather)
  end

  test "should destroy weather" do
    assert_difference('Weather.count', -1) do
      delete weather_url(@weather)
    end

    assert_redirected_to weathers_url
  end
end
