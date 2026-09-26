class RwEltrainsTimetablesController < ApplicationController
  before_action :set_rw_eltrains_timetable, only: [:show, :edit, :update, :destroy]
  before_action :set_authorize, nly: [:admin_rw_eltrains_timetables, :add_eltrain, :create_bulk, :edit_bulk, :update_bulk, :destroy_bulk, :show_eltrain, :search_eltrains]

  def search_eltrains
    if params[:search_eltrains]
      @station_start = Station.find(params[:search_eltrains][:station_start_id])
      @station_finish = Station.find(params[:search_eltrains][:station_finish_id])
      @rw_routes = RwEltrainsRoute.select(:rw_route_id).where("station_id = ? OR station_id = ?", "#{@station_start.id}", "#{@station_finish.id}").group(:rw_route_id).having("count(rw_route_id) > 1").count.keys
      @search_eltrains_all = []
      @rw_routes.each do |rw_r|
        rw_route = RwRoute.find(rw_r)
        rw_eltrains_route_start = rw_route.rw_eltrains_routes.find_by(station_id: @station_start.id)
        rw_eltrains_route_finish = rw_route.rw_eltrains_routes.find_by(station_id: @station_finish.id)
        rw_priority = rw_eltrains_route_start.priority_direct < rw_eltrains_route_finish.priority_direct ? 0 : 1
        rw_eltrains_routes = rw_route.rw_eltrains_routes.select(:id).where("station_id = ? OR station_id = ?", "#{@station_start.id}", "#{@station_finish.id}")
        eltrains_numbers = rw_route.rw_eltrains_timetables.select(:eltrains_number).where(direction: rw_priority).where("0 = CASE WHEN rw_eltrains_timetables.station_id = #{@station_start.id} AND rw_eltrains_timetables.time_finish IS NOT NULL THEN 1  WHEN rw_eltrains_timetables.station_id = #{@station_finish.id} AND rw_eltrains_timetables.time_start IS NOT NULL THEN 1 ELSE 0 END ").group(:eltrains_number).pluck(:eltrains_number)
#        p eltrains_numbers
        @rw_eltrains_timetables = rw_route.rw_eltrains_timetables.where(eltrains_number: eltrains_numbers).where(station_id: @station_start.id).or(rw_route.rw_eltrains_timetables.where(eltrains_number: eltrains_numbers).where(station_id: @station_finish.id))
        eltrains_numbers.each do |e|
          rw_search_eltrains = SearchEltrains.new
          rw_search_eltrains.eltrains_number = e
          rw_search_eltrains.station_start_id = @station_start.id
          rw_search_eltrains.rw_route_id = rw_route.id
          rw_search_eltrains.station_finish_id = @station_finish.id
          rw_search_eltrains.station_start_time = @rw_eltrains_timetables.where(eltrains_number: e).where(station_id: @station_start.id).pluck(:time_finish).first
          rw_search_eltrains.station_finish_time = @rw_eltrains_timetables.where(eltrains_number: e).where(station_id: @station_finish.id).pluck(:time_start).first
          @search_eltrains_all = @search_eltrains_all.push(rw_search_eltrains)
          p @search_eltrains_all
        end
        p @search_eltrains
      end
    end
  end

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
