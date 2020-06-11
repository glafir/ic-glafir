class AirportStatesController < ApplicationController
  before_action :set_airport_state, only: [:show, :edit, :update, :destroy]

  # GET /airport_states
  def index
    @airport_states = AirportState.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @airport_states
    respond_with @airport_states
  end

  # GET /airport_states/1
  def show
    authorize @airport_state
    respond_with @airport_state
  end

  # GET /airport_states/new
  def new
    @airport_state = AirportState.new
    authorize @airport_state
    respond_with @airport_state
  end

  # GET /airport_states/1/edit
  def edit
    authorize @airport_state
  end

  # POST /airport_states
  def create
    @airport_state = AirportState.new(airport_state_params)
    authorize @airport_state
    @airport_state.save
    flash[:notice] =  'The airport_state was successfully saved!' if @airport_state.save && !request.xhr?
    respond_with @airport_state
  end

  # PATCH/PUT /airport_states/1
  def update
    @airport_state.update(airport_state_params)
    authorize @airport_state
    flash[:notice] =  'The airport_state was successfully updated!' if @airport_state.update(airport_state_params) && !request.xhr?
    respond_with @airport_state
  end

  # DELETE /airport_states/1
  def destroy
    authorize @airport_state
    @airport_state.destroy
    redirect_to airport_states_url, notice: 'Airport state was successfully destroyed.'  if @airport_state.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport_state
      @airport_state = AirportState.find(params[:id])
    end

    def sort_column
      AirportState.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    # Only allow a trusted parameter "white list" through.
    def airport_state_params
      params.require(:airport_state).permit(:name)
    end
end
