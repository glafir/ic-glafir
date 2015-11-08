class StationsController < ApplicationController
  before_action :set_station, only: [:show, :edit, :update, :destroy]

  # GET /stations
  def index
    @stations = Station.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    authorize Station.all
    respond_with @stations
  end

  # GET /stations/1
  def show
    authorize @station
    respond_with @station
  end

  # GET /stations/new
  def new
    @station = Station.new
    authorize @station
    respond_with @station
  end

  # GET /stations/1/edit
  def edit
    authorize @station
  end

  # POST /stations
  def create
    @station = Station.new(station_params)
    @station.save
    flash[:notice] =  'The station was successfully saved!' if @station.save && !request.xhr?
    authorize @station
    respond_with @station
  end

  # PATCH/PUT /stations/1
  def update
    @station.update(station_params)
    flash[:notice] =  'The station was successfully updated!' if @station.update(station_params) && !request.xhr?
    authorize @station
    respond_with @station
  end

  # DELETE /stations/1
  def destroy
    @station.destroy
    authorize @station
    redirect_to stations_url, notice: 'Station was successfully destroyed.'
    respond_with @station
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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
