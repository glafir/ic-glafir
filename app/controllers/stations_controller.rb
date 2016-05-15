class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]

  def admin_stations
    authorize :station
  end

  def index
    @stations = Station.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    authorize @stations
    respond_with @stations
  end

  def show
    authorize @station
    respond_with @station
  end

  def new
    @station = Station.new
    authorize @station
    respond_with @station
  end

  def edit
    authorize @station
  end

  def create
    @station = Station.new(station_params)
    authorize @station
    flash[:notice] =  'The station was successfully saved!' if @station.save && !request.xhr?
    respond_with @station
  end

  def update
    authorize @station
    flash[:notice] =  'The station was successfully updated!' if @station.update(station_params) && !request.xhr?
    respond_with @station
  end

  def destroy
    authorize @station
    @station.destroy
    redirect_to stations_url, notice: 'Station was successfully destroyed.'
    respond_with @station
  end

  private
    def set_station
      @station = Station.find(params[:id])
    end

    def sort_column
      Station.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def station_params
      params.require(:station).permit(:name_rus, :name_eng, :station_zone_id, :station_type_id, :rw_route_id)
    end
end
