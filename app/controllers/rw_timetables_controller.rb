class RwTimetablesController < ApplicationController
  before_action :set_rw_timetable, only: [:show, :edit, :update, :destroy]

  # GET /rw_timetables
  def index
    @rw_timetables = RwTimetable.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @rw_timetables
    respond_with @rw_timetables
  end

  # GET /rw_timetables/1
  def show
    authorize @rw_timetable
    respond_with @rw_timetable
  end

  # GET /rw_timetables/new
  def new
    @rw_timetable = RwTimetable.new
    authorize @rw_timetable
    respond_with @rw_timetable
  end

  # GET /rw_timetables/1/edit
  def edit
    authorize @rw_timetable
  end

  # POST /rw_timetables
  def create
    @rw_timetable = RwTimetable.new(rw_timetable_params)
    authorize @rw_timetable
    flash[:notice] =  'The rw_timetable was successfully saved!' if @rw_timetable.save && !request.xhr?
    respond_with @rw_timetable
  end

  # PATCH/PUT /rw_timetables/1
  def update
    @rw_timetable.update(rw_timetable_params)
    authorize @rw_timetable
    flash[:notice] =  'The rw_timetable was successfully updated!' if @rw_timetable.update(rw_timetable_params) && !request.xhr?
    respond_with @rw_timetable
  end

  # DELETE /rw_timetables/1
  def destroy
    authorize @rw_timetable
    redirect_to rw_timetables_url, notice: 'Rw timetable was successfully destroyed.'  if @rw_timetable.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rw_timetable
      @rw_timetable = RwTimetable.find(params[:id])
    end

    def sort_column
      RwTimetable.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def rw_timetable_params
      params.require(:rw_timetable).permit(:train_id, :station_id, :time_arr, :time_dep)
    end
end
