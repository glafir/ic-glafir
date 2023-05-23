class StationZonesController < ApplicationController
  before_action :set_station_zone, only: [:show, :edit, :update, :destroy]

  def admin_station_zones
    authorize :station_zone
  end

  # GET /station_zones
  def index
    @station_zones = StationZone.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    authorize StationZone.all
    respond_with @station_zones
  end

  # GET /station_zones/1
  def show
    authorize @station_zone
    respond_with @station_zone
  end

  # GET /station_zones/new
  def new
    @station_zone = StationZone.new
    authorize @station_zone
    respond_with @station_zone
  end

  # GET /station_zones/1/edit
  def edit
    authorize @station_zone
  end

  # POST /station_zones
  def create
    @station_zone = StationZone.new(station_zone_params)
    @station_zone.save
    flash[:notice] =  'The station_zone was successfully saved!' if @station_zone.save && !request.xhr?
    authorize @station_zone
    respond_with @station_zone
  end

  # PATCH/PUT /station_zones/1
  def update
    @station_zone.update(station_zone_params)
    flash[:notice] =  'The station_zone was successfully updated!' if @station_zone.update(station_zone_params) && !request.xhr?
    authorize @station_zone
    respond_with @station_zone
  end

  # DELETE /station_zones/1
  def destroy
    @station_zone.destroy
    authorize @station_zone
    redirect_to station_zones_url, notice: 'Station zone was successfully destroyed.'
    respond_with @station_zone
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station_zone
      @station_zone = StationZone.find(params[:id])
    end

    def sort_column
      StationZone.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def station_zone_params
      params.require(:station_zone).permit(:zone)
    end
end
