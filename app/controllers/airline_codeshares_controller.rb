class AirlineCodesharesController < ApplicationController
  before_action :set_airline_codeshare, only: [:show, :edit, :update, :destroy]

  # GET /airline_codeshares
  def index
    @airline_codeshares = AirlineCodeshare.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @airline_codeshares
    respond_with @airline_codeshares
  end

  # GET /airline_codeshares/1
  def show
    authorize @airline_codeshare
    respond_with @airline_codeshare
  end

  # GET /airline_codeshares/new
  def new
    @airline_codeshare = AirlineCodeshare.new
    authorize @airline_codeshare
    respond_with @airline_codeshare
  end

  # GET /airline_codeshares/1/edit
  def edit
    authorize @airline_codeshare
  end

  # POST /airline_codeshares
  def create
    @airline_codeshare = AirlineCodeshare.new(airline_codeshare_params)
    authorize @airline_codeshare
    flash[:notice] =  'The airline_codeshare was successfully saved!' if @airline_codeshare.save && !request.xhr?
    respond_with @airline_codeshare
  end

  # PATCH/PUT /airline_codeshares/1
  def update
    @airline_codeshare.update(airline_codeshare_params)
    authorize @airline_codeshare
    flash[:notice] =  'The airline_codeshare was successfully updated!' if @airline_codeshare.update(airline_codeshare_params) && !request.xhr?
    respond_with @airline_codeshare
  end

  # DELETE /airline_codeshares/1
  def destroy
    authorize @airline_codeshare
    redirect_to airline_codeshares_url, notice: 'Airline codeshare was successfully destroyed.'  if @airline_codeshare.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airline_codeshare
      @airline_codeshare = AirlineCodeshare.find(params[:id])
    end

    def sort_column
      AirlineCodeshare.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def airline_codeshare_params
      params.require(:airline_codeshare).permit(:aircompany_id, :codeshare_id, :code_share_start, :code_share_finish)
    end
end
