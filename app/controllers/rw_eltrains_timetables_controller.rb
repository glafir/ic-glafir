class RwEltrainsTimetablesController < ApplicationController
  before_action :set_rw_eltrains_timetable, only: [:show, :edit, :update, :destroy]
  before_action :set_authorize, nly: [:admin_rw_eltrains_timetables, :add_eltrain, :create_bulk, :edit_bulk, :update_bulk, :destroy_bulk, :show_eltrain, :search_eltrains]

  def search_eltrains
    if params[:search_eltrains]
      @station_start = Station.find(params[:search_eltrains][:station_start_id])
      @station_finish = Station.find(params[:search_eltrains][:station_finish_id])
      rw_eltrains_routes = RwEltrainsRoute.select(:id).where("station_id = ? OR station_id = ?", "#{@station_start.id}", "#{@station_finish.id}").group(:rw_route_id)
#.having("count(rw_route_id) > 1")
      @rw_eltrains_timetables = RwEltrainsTimetable.where(:rw_eltrains_route_id => rw_eltrains_routes).where.not(time_start: nil).where.not(time_finish: nil).group(:eltrains_number).order(:time_finish)
      p rw_eltrains_routes
      @rw_eltrains_timetables.each {|tt|p tt.eltrains_number; p tt.station_id}
    end
  end

  def admin_rw_eltrains_timetables
  end

  def add_eltrain
    @rw_route = RwRoute.find(params[:id])
  end

  def show_eltrain
    @eltrain = RwEltrainsTimetable.where(eltrains_number: params[:id])
    @eltrain = @eltrain.order_by_priority_direct_asc if @eltrain[0].direction == 0
    @eltrain = @eltrain.order_by_priority_direct_desc if @eltrain[0].direction == 1
  end

  def create_bulk
    @rw_route = RwRoute.find(params[:rw_route_id])
    rw_eltrains_timetables = params.require(:rw_eltrains_timetables).values().map { |attrs| RwEltrainsTimetable.new(attrs) }
    RwEltrainsTimetable.import rw_eltrains_timetables, valodate: true
    respond_with @rw_route
  end

  # GET /rw_eltrains_timetables
  def index
    @rw_routes = RwRoute.all
    authorize @rw_routes
    respond_with @rw_routes
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
      params.require(:rw_eltrains_timetable).permit(:rw_eltrains_route_id, :direction, :time_start, :time_finish, :w1, :w2, :w3, :w4, :w5, :w6, :w0, :eltrains_number, :station_id, :rw_route_id, :direction)
    end
end
