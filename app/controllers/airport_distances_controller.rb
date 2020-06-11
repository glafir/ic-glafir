class AirportDistancesController < ApplicationController
  before_action :set_airport_distance, only: [:show, :edit, :update, :destroy]

  # GET /airport_distances
  def index
    @airport_distances = AirportDistance.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @airport_distances
    respond_with @airport_distances
  end

  # GET /airport_distances/1
  def show
    authorize @airport_distance
    respond_with @airport_distance
  end

  # GET /airport_distances/new
  def new
    @airport_distance = AirportDistance.new
    authorize @airport_distance
    respond_with @airport_distance
  end

  # GET /airport_distances/1/edit
  def edit
    authorize @airport_distance
  end

  # POST /airport_distances
  def create
    @airport_distance = AirportDistance.new(airport_distance_params)
    authorize @airport_distance
    flash[:notice] =  'The airport_distance was successfully saved!' if @airport_distance.save && !request.xhr?
    respond_with @airport_distance
  end

  # PATCH/PUT /airport_distances/1
  def update
    @airport_distance.update(airport_distance_params)
    authorize @airport_distance
    flash[:notice] =  'The airport_distance was successfully updated!' if @airport_distance.update(airport_distance_params) && !request.xhr?
    respond_with @airport_distance
  end

  # DELETE /airport_distances/1
  def destroy
    authorize @airport_distance
    redirect_to airport_distances_url, notice: 'Airport distance was successfully destroyed.'  if @airport_distance.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport_distance
      @airport_distance = AirportDistance.find(params[:id])
    end

    def sort_column
      AirportDistance.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def airport_distance_params
      params.require(:airport_distance).permit(:airport_start_id, :airport_finish_id, :distance)
    end
end
