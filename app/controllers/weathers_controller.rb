class WeathersController < ApplicationController
  before_action :set_weather, only: [:show, :edit, :update, :destroy]

  # GET /weathers
  def index
    @weathers = Weather.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @weathers
    respond_with @weathers
  end

  def weather_grub
    @airports = Airport.where(country_id:528).where("updated_at < ?", Time.now.utc-3.minute).limit(1)
    @airports.each {|airport|
      airport_wheather = Openweather2.get_weather(lat: airport.latitude, lon: airport.longitude)
      weather = Weather.new
      weather.place_id = airport.id
      weather.temp = airport_wheather.temperature
      weather.temp_min = airport_wheather.min_temperature
      weather.temp_max = airport_wheather.max_temperature
      weather.pressure = airport_wheather.pressure
      weather.pressure_sea_level = airport_wheather.pressure_sea_level
      weather.pressure_grnd_level = airport_wheather.pressure_grnd_level
      weather.wind_speed = airport_wheather.wind_speed
      weather.wind_deg = airport_wheather.wind_angle
      weather.clouds = airport_wheather.clouds
      weather.dt = airport_wheather.dt
      weather.humidity = airport_wheather.humidity
      weather.save
      airport_wheather.main.each {|w|
        weather_state = WeatherState.new
        weather_state.weather_id = weather.id
        weather_state.main = w['main']
        weather_state.description = w['description']
        weather_state.icon = w['icon']
        weather_state.save
      }
      airport.updated_at = Time.now.utc
    airport.save}
    render json: @airports
  end

  # GET /weathers/1
  def show
    authorize @weather
    respond_with @weather
  end

  # GET /weathers/new
  def new
    @weather = Weather.new
    authorize @weather
    respond_with @weather
  end

  # GET /weathers/1/edit
  def edit
    authorize @weather
  end

  # POST /weathers
  def create
    @weather = Weather.new(weather_params)
    authorize @weather
    flash[:notice] =  'The weather was successfully saved!' if @weather.save && !request.xhr?
    respond_with @weather
  end

  # PATCH/PUT /weathers/1
  def update
    @weather.update(weather_params)
    authorize @weather
    flash[:notice] =  'The weather was successfully updated!' if @weather.update(weather_params) && !request.xhr?
    respond_with @weather
  end

  # DELETE /weathers/1
  def destroy
    authorize @weather
    redirect_to weathers_url, notice: 'Weather was successfully destroyed.'  if @weather.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather
      @weather = Weather.find(params[:id])
    end

    def sort_column
      Weather.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def weather_params
      params.require(:weather).permit(:place_id, :temp, :temp_min, :temp_max, :pressure, :pressure_sea_level, :pressure_grnd_level, :wind_speed, :wind_deg, :clouds, :dt, :humidity)
    end
end
