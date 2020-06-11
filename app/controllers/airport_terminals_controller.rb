class AirportTerminalsController < ApplicationController
  before_action :set_airport_terminal, only: [:show, :edit, :update, :destroy]

  # GET /airport_terminals
  def index
    @airport_terminals = AirportTerminal.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @airport_terminals
    respond_with @airport_terminals
  end

  # GET /airport_terminals/1
  def show
    authorize @airport_terminal
    respond_with @airport_terminal
  end

  # GET /airport_terminals/new
  def new
    @airport_terminal = AirportTerminal.new
    authorize @airport_terminal
    respond_with @airport_terminal
  end

  # GET /airport_terminals/1/edit
  def edit
    authorize @airport_terminal
  end

  # POST /airport_terminals
  def create
    @airport_terminal = AirportTerminal.new(airport_terminal_params)
    authorize @airport_terminal
    flash[:notice] =  'The airport_terminal was successfully saved!' if @airport_terminal.save && !request.xhr?
    respond_with @airport_terminal
  end

  # PATCH/PUT /airport_terminals/1
  def update
    @airport_terminal.update(airport_terminal_params)
    authorize @airport_terminal
    flash[:notice] =  'The airport_terminal was successfully updated!' if @airport_terminal.update(airport_terminal_params) && !request.xhr?
    respond_with @airport_terminal
  end

  # DELETE /airport_terminals/1
  def destroy
    authorize @airport_terminal
    redirect_to airport_terminals_url, notice: 'Airport terminal was successfully destroyed.'  if @airport_terminal.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport_terminal
      @airport_terminal = AirportTerminal.find(params[:id])
    end

    def sort_column
      AirportTerminal.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def airport_terminal_params
      params.require(:airport_terminal).permit(:airport_id, :terminal)
    end
end
