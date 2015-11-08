class StationTypesController < ApplicationController
  before_action :set_station_type, only: [:show, :edit, :update, :destroy]

  # GET /station_types
  def index
    @station_types = StationType.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    authorize StationType.all
    respond_with @station_types
  end

  # GET /station_types/1
  def show
    authorize @station_type
    respond_with @station_type
  end

  # GET /station_types/new
  def new
    @station_type = StationType.new
    authorize @station_type
    respond_with @station_type
  end

  # GET /station_types/1/edit
  def edit
    authorize @station_type
  end

  # POST /station_types
  def create
    @station_type = StationType.new(station_type_params)
    @station_type.save
    flash[:notice] =  'The station_type was successfully saved!' if @station_type.save && !request.xhr?
    authorize @station_type
    respond_with @station_type
  end

  # PATCH/PUT /station_types/1
  def update
    @station_type.update(station_type_params)
    flash[:notice] =  'The station_type was successfully updated!' if @station_type.update(station_type_params) && !request.xhr?
    authorize @station_type
    respond_with @station_type
  end

  # DELETE /station_types/1
  def destroy
    @station_type.destroy
    authorize @station_type
    redirect_to station_types_url, notice: 'Station type was successfully destroyed.'
    respond_with @station_type
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station_type
      @station_type = StationType.find(params[:id])
    end

    def sort_column
      StationType.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def station_type_params
      params.require(:station_type).permit(:typename)
    end
end
