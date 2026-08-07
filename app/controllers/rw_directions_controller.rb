class RwDirectionsController < ApplicationController
  before_action :set_rw_direction, only: [:show, :edit, :update, :destroy]

  def admin_rw_directions
    authorize :rw_direction
  end

  # GET /rw_directions
  def index
    @rw_directions = RwDirection.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @rw_directions
    respond_with @rw_directions
  end

  # GET /rw_directions/1
  def show
    authorize @rw_direction
    respond_with @rw_direction
  end

  # GET /rw_directions/new
  def new
    @rw_direction = RwDirection.new
    authorize @rw_direction
    respond_with @rw_direction
  end

  # GET /rw_directions/1/edit
  def edit
    authorize @rw_direction
  end

  # POST /rw_directions
  def create
    @rw_direction = RwDirection.new(rw_direction_params)
    authorize @rw_direction
    flash[:notice] =  'The rw_direction was successfully saved!' if @rw_direction.save && !request.xhr?
    respond_with @rw_direction
  end

  # PATCH/PUT /rw_directions/1
  def update
    @rw_direction.update(rw_direction_params)
    authorize @rw_direction
    flash[:notice] =  'The rw_direction was successfully updated!' if @rw_direction.update(rw_direction_params) && !request.xhr?
    respond_with @rw_direction
  end

  # DELETE /rw_directions/1
  def destroy
    authorize @rw_direction
    if @rw_direction.destroy && !request.xhr?
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rw_direction
      @rw_direction = RwDirection.find(params[:id])
    end

    def sort_column
      RwDirection.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def rw_direction_params
      params.require(:rw_direction).permit(:station_id, :direction_station_id)
    end
end
