module Openweather2
  class Weather

    attr_reader :city, :longitude, :latitude, :pressure, :humidity, :clouds,
      :temperature, :min_temperature, :max_temperature, :wind_speed, :wind_angle, :visibility, :info, :description, :dt, :pressure_grnd_level, :pressure_sea_level, :main

    def initialize(json)
      @info = json['weather']
      @main = json['weather']
      @description = json['weather'].first['description']
      @city = json['name']
      @longitude = json['coord'] && json['coord']['lon']
      @latitude = json['coord'] && json['coord']['lat']
      @temperature = json['main']['temp']
      @pressure = json['main']['pressure']
      @pressure_sea_level = json['main']['sea_level']
      @pressure_grnd_level = json['main']['grnd_level']
      @humidity = json['main']['humidity']
      @min_temperature = json['main']['temp_min']
      @max_temperature = json['main']['temp_max']
      @visibility = json['main']['visibility']
      @clouds = json['clouds']['all']
      @wind_speed = json['wind']['speed']
      @wind_angle = json['wind']['deg']
      @dt = json['dt']
    end
  end
end
