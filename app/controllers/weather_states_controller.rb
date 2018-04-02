class WeatherStatesController < ApplicationController
  before_action :set_weather
  before_action :set_weather_state, only: [:show, :edit, :update, :destroy]

  # GET /weather_states
  def index
    @weather_states = WeatherState.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @weather_states
    respond_with @weather_states
  end

  # GET /weather_states/1
  def show
    authorize @weather_state
    respond_with @weather_state
  end

  # GET /weather_states/new
  def new
    @weather_state = WeatherState.new
    authorize @weather_state
    respond_with @weather_state
  end

  # GET /weather_states/1/edit
  def edit
    authorize @weather_state
  end

  # POST /weather_states
  def create
    @weather_state = WeatherState.new(weather_state_params)
    authorize @weather_state
    flash[:notice] =  'The weather_state was successfully saved!' if @weather_state.save && !request.xhr?
    respond_with @weather_state
  end

  # PATCH/PUT /weather_states/1
  def update
    @weather_state.update(weather_state_params)
    authorize @weather_state
    flash[:notice] =  'The weather_state was successfully updated!' if @weather_state.update(weather_state_params) && !request.xhr?
    respond_with @weather_state
  end

  # DELETE /weather_states/1
  def destroy
    authorize @weather_state
    redirect_to weather_states_url, notice: 'Weather state was successfully destroyed.'  if @weather_state.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather
      @weather_state = Weather.find(params[:weather_id])
    end

    def set_weather_state
      @weather_state = WeatherState.find(params[:id])
    end

    def sort_column
      WeatherState.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def weather_state_params
      params.require(:weather_state).permit(:weather_id, :main, :description, :icon)
    end
end
