class RwEltrainsRoutesController < ApplicationController
  before_action :set_rw_eltrains_route, only: [:show, :edit, :update, :destroy]

  def admin_rw_eltrains_routes
    authorize :rw_eltrains_route
  end


  # GET /rw_eltrains_routes
  def index
    @rw_eltrains_routes = RwEltrainsRoute.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @rw_eltrains_routes
    respond_with @rw_eltrains_routes
  end

  # GET /rw_eltrains_routes/1
  def show
    authorize @rw_eltrains_route
    respond_with @rw_eltrains_route
  end

  # GET /rw_eltrains_routes/new
  def new
    @rw_eltrains_route = RwEltrainsRoute.new
    authorize @rw_eltrains_route
    respond_with @rw_eltrains_route
  end

  # GET /rw_eltrains_routes/1/edit
  def edit
    authorize @rw_eltrains_route
  end

  # POST /rw_eltrains_routes
  def create
    @rw_eltrains_route = RwEltrainsRoute.new(rw_eltrains_route_params)
    authorize @rw_eltrains_route
    flash[:notice] =  'The rw_eltrains_route was successfully saved!' if @rw_eltrains_route.save && !request.xhr?
    respond_with @rw_eltrains_route
  end

  # PATCH/PUT /rw_eltrains_routes/1
  def update
    @rw_eltrains_route.update(rw_eltrains_route_params)
    authorize @rw_eltrains_route
    flash[:notice] =  'The rw_eltrains_route was successfully updated!' if @rw_eltrains_route.update(rw_eltrains_route_params) && !request.xhr?
    respond_with @rw_eltrains_route
  end

  # DELETE /rw_eltrains_routes/1
  def destroy
    authorize @rw_eltrains_route
    if @rw_eltrains_route.destroy && !request.xhr?
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rw_eltrains_route
      @rw_eltrains_route = RwEltrainsRoute.find(params[:id])
    end

    def sort_column
      RwEltrainsRoute.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def rw_eltrains_route_params
      params.require(:rw_eltrains_route).permit(:station_id, :priority_direct, :number)
    end
end
