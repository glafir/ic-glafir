class RwEltrainsTimetablesController < ApplicationController
  before_action :set_rw_eltrains_timetable, only: [:show, :edit, :update, :destroy]
  before_action :set_authorize, nly: [:admin_rw_eltrains_timetables, :add_eltrain, :create_bulk, :edit_bulk, :update_bulk, :destroy_bulk]

  def admin_rw_eltrains_timetables
  end

  def add_eltrain
    @rw_route = RwRoute.find(params[:id])
  end

  def create_bulk
    @rw_route = RwRoute.find(params[:rw_route_id])
    @rw_eltrains_route_count = @rw_route.rw_eltrains_routes.count
    rw_eltrains_timetables = rw_eltrains_timetable_params.map { |attrs| RwEltrainsTimetable.new(attrs) }
#    @rw_eltrains_route_count.times do |i|
#      rw_eltrains_timetables << RwEltrainsTimetable.new(name: "rw_eltrains_timetable #{i}")
#    end
    RwEltrainsTimetable.import rw_eltrains_timetables
    respond_with @rw_route
  end

  # GET /rw_eltrains_timetables
  def index
    @rw_eltrains_timetables = RwEltrainsTimetable.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @rw_eltrains_timetables
    respond_with @rw_eltrains_timetables
  end

  # GET /rw_eltrains_timetables/1
  def show
    authorize @rw_eltrains_timetable
    respond_with @rw_eltrains_timetable
  end

  # GET /rw_eltrains_timetables/new
  def new
    @rw_eltrains_timetable = RwEltrainsTimetable.new
    authorize @rw_eltrains_timetable
    respond_with @rw_eltrains_timetable
  end

  # GET /rw_eltrains_timetables/1/edit
  def edit
    authorize @rw_eltrains_timetable
  end

  # POST /rw_eltrains_timetables
  def create
    @rw_eltrains_timetable = RwEltrainsTimetable.new(rw_eltrains_timetable_params)
    authorize @rw_eltrains_timetable
    flash[:notice] =  'The rw_eltrains_timetable was successfully saved!' if @rw_eltrains_timetable.save && !request.xhr?
    respond_with @rw_eltrains_timetable
  end

  # PATCH/PUT /rw_eltrains_timetables/1
  def update
    @rw_eltrains_timetable.update(rw_eltrains_timetable_params)
    authorize @rw_eltrains_timetable
    flash[:notice] =  'The rw_eltrains_timetable was successfully updated!' if @rw_eltrains_timetable.update(rw_eltrains_timetable_params) && !request.xhr?
    respond_with @rw_eltrains_timetable
  end

  # DELETE /rw_eltrains_timetables/1
  def destroy
    authorize @rw_eltrains_timetable
    if @rw_eltrains_timetable.destroy && !request.xhr?
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rw_eltrains_timetable
      @rw_eltrains_timetable = RwEltrainsTimetable.find(params[:id])
    end

    def sort_column
      RwEltrainsTimetable.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def set_authorize
      authorize :rw_eltrains_timetable
    end

    # Only allow a trusted parameter "white list" through.
    def rw_eltrains_timetable_params
      params.require(:rw_eltrains_timetable).permit(:rw_eltrains_route_id, :direction, :time_start, :time_finish, :w1, :w2, :w3, :w4, :w5, :w6, :w0, :eltrains_number, :station_id)
    end
end
