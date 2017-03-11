class TerminalsController < ApplicationController
  before_action :set_terminal, only: [:show, :edit, :update, :destroy]

  # GET /terminals
  def index
    @terminals = Terminal.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @terminals
    respond_with @terminals
  end

  # GET /terminals/1
  def show
    authorize @terminal
    respond_with @terminal
  end

  # GET /terminals/new
  def new
    @terminal = Terminal.new
    authorize @terminal
    respond_with @terminal
  end

  # GET /terminals/1/edit
  def edit
    authorize @terminal
  end

  # POST /terminals
  def create
    @terminal = Terminal.new(terminal_params)
    authorize @terminal
    flash[:notice] =  'The terminal was successfully saved!' if @terminal.save && !request.xhr?
    respond_with @terminal
  end

  # PATCH/PUT /terminals/1
  def update
    @terminal.update(terminal_params)
    authorize @terminal
    flash[:notice] =  'The terminal was successfully updated!' if @terminal.update(terminal_params) && !request.xhr?
    respond_with @terminal
  end

  # DELETE /terminals/1
  def destroy
    authorize @terminal
    redirect_to terminals_url, notice: 'Terminal was successfully destroyed.'  if @terminal.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_terminal
      @terminal = Terminal.find(params[:id])
    end

    def sort_column
      Terminal.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def terminal_params
      params.require(:terminal).permit(:name, :marking, :floor, :reception, :parking, :teletrap, :gate, :airport_id, :area)
    end
end
