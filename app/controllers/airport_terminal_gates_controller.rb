class AirportTerminalGatesController < ApplicationController
  before_action :set_airport_terminal_gate, only: [:show, :edit, :update, :destroy]

  # GET /airport_terminal_gates
  def index
    @airport_terminal_gates = AirportTerminalGate.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @airport_terminal_gates
    respond_with @airport_terminal_gates
  end

  # GET /airport_terminal_gates/1
  def show
    authorize @airport_terminal_gate
    respond_with @airport_terminal_gate
  end

  # GET /airport_terminal_gates/new
  def new
    @airport_terminal_gate = AirportTerminalGate.new
    authorize @airport_terminal_gate
    respond_with @airport_terminal_gate
  end

  # GET /airport_terminal_gates/1/edit
  def edit
    authorize @airport_terminal_gate
  end

  # POST /airport_terminal_gates
  def create
    @airport_terminal_gate = AirportTerminalGate.new(airport_terminal_gate_params)
    authorize @airport_terminal_gate
    flash[:notice] =  'The airport_terminal_gate was successfully saved!' if @airport_terminal_gate.save && !request.xhr?
    respond_with @airport_terminal_gate
  end

  # PATCH/PUT /airport_terminal_gates/1
  def update
    @airport_terminal_gate.update(airport_terminal_gate_params)
    authorize @airport_terminal_gate
    flash[:notice] =  'The airport_terminal_gate was successfully updated!' if @airport_terminal_gate.update(airport_terminal_gate_params) && !request.xhr?
    respond_with @airport_terminal_gate
  end

  # DELETE /airport_terminal_gates/1
  def destroy
    authorize @airport_terminal_gate
    redirect_to airport_terminal_gates_url, notice: 'Airport terminal gate was successfully destroyed.'  if @airport_terminal_gate.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport_terminal_gate
      @airport_terminal_gate = AirportTerminalGate.find(params[:id])
    end

    def sort_column
      AirportTerminalGate.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def airport_terminal_gate_params
      params.require(:airport_terminal_gate).permit(:airport_terminal_id, :gate)
    end
end
