class AirportAirTrafficsController < ApplicationController
  before_action :set_airport_air_traffic, only: [:show, :edit, :update, :destroy]

  # GET /airport_air_traffics
  def index
    @airport_air_traffics = AirportAirTraffic.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @airport_air_traffics
    respond_with @airport_air_traffics
  end

  # GET /airport_air_traffics/1
  def show
    authorize @airport_air_traffic
    respond_with @airport_air_traffic
  end

  # GET /airport_air_traffics/new
  def new
    @airport_air_traffic = AirportAirTraffic.new
    authorize @airport_air_traffic
    respond_with @airport_air_traffic
  end

  # GET /airport_air_traffics/1/edit
  def edit
    authorize @airport_air_traffic
  end

  # POST /airport_air_traffics
  def create
    @airport_air_traffic = AirportAirTraffic.new(airport_air_traffic_params)
    authorize @airport_air_traffic
    @airport_air_traffic.save
    flash[:notice] =  'The airport_air_traffic was successfully saved!' if @airport_air_traffic.save && !request.xhr?
    respond_with @airport_air_traffic
  end

  # PATCH/PUT /airport_air_traffics/1
  def update
    @airport_air_traffic.update(airport_air_traffic_params)
    authorize @airport_air_traffic
    flash[:notice] =  'The airport_air_traffic was successfully updated!' if @airport_air_traffic.update(airport_air_traffic_params) && !request.xhr?
    respond_with @airport_air_traffic
  end

  # DELETE /airport_air_traffics/1
  def destroy
    authorize @airport_air_traffic
    @airport_air_traffic.destroy
    redirect_to airport_air_traffics_url, notice: 'Airport air traffic was successfully destroyed.'  if @airport_air_traffic.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport_air_traffic
      @airport_air_traffic = AirportAirTraffic.find(params[:id])
    end

    def _params
      params.require(:).permit()
    end

    def sort_column
#      AirportAirTraffic.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
      params[:sort] || "city_rus"
    end


    # Only allow a trusted parameter "white list" through.
    def airport_air_traffic_params
      params.require(:airport_air_traffic).permit(:name, :klass)
    end
end
