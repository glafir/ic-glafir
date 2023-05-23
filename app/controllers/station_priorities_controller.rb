class StationPrioritiesController < ApplicationController
  before_action :set_station_priority, only: [:show, :edit, :update, :destroy]

  # GET /station_priorities
  def index
    @station_priorities = StationPriority.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @station_priorities
    respond_with @station_priorities
  end

  # GET /station_priorities/1
  def show
    authorize @station_priority
    respond_with @station_priority
  end

  # GET /station_priorities/new
  def new
    @station_priority = StationPriority.new
    authorize @station_priority
    respond_with @station_priority
  end

  # GET /station_priorities/1/edit
  def edit
    authorize @station_priority
  end

  # POST /station_priorities
  def create
    @station_priority = StationPriority.new(station_priority_params)
    authorize @station_priority
    flash[:notice] =  'The station_priority was successfully saved!' if @station_priority.save && !request.xhr?
    respond_with @station_priority
  end

  # PATCH/PUT /station_priorities/1
  def update
    @station_priority.update(station_priority_params)
    authorize @station_priority
    flash[:notice] =  'The station_priority was successfully updated!' if @station_priority.update(station_priority_params) && !request.xhr?
    respond_with @station_priority
  end

  # DELETE /station_priorities/1
  def destroy
    authorize @station_priority
    redirect_to station_priorities_url, notice: 'Station priority was successfully destroyed.'  if @station_priority.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station_priority
      @station_priority = StationPriority.find(params[:id])
    end

    def sort_column
      StationPriority.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def station_priority_params
      params.require(:station_priority).permit(:station_id, :rw_route_id, :priority)
    end
end
