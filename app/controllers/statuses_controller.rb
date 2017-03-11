class StatusesController < ApplicationController
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  def index
    @statuses = Status.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @statuses
    respond_with @statuses
  end

  # GET /statuses/1
  def show
    authorize @status
    respond_with @status
  end

  # GET /statuses/new
  def new
    @status = Status.new
    authorize @status
    respond_with @status
  end

  # GET /statuses/1/edit
  def edit
    authorize @status
  end

  # POST /statuses
  def create
    @status = Status.new(status_params)
    authorize @status
    flash[:notice] =  'The status was successfully saved!' if @status.save && !request.xhr?
    respond_with @status
  end

  # PATCH/PUT /statuses/1
  def update
    @status.update(status_params)
    authorize @status
    flash[:notice] =  'The status was successfully updated!' if @status.update(status_params) && !request.xhr?
    respond_with @status
  end

  # DELETE /statuses/1
  def destroy
    authorize @status
    redirect_to statuses_url, notice: 'Status was successfully destroyed.'  if @status.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    def sort_column
      Status.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:name)
    end
end
