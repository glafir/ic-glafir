class TrainsController < ApplicationController
  before_action :set_train, only: [:show, :edit, :update, :destroy]

  # GET /trains
  def index
    @trains = Train.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize @trains
    respond_with @trains
  end

  # GET /trains/1
  def show
    authorize @train
    respond_with @train
  end

  # GET /trains/new
  def new
    @train = Train.new
    authorize @train
    respond_with @train
  end

  # GET /trains/1/edit
  def edit
    authorize @train
  end

  # POST /trains
  def create
    @train = Train.new(train_params)
    authorize @train
    flash[:notice] =  'The train was successfully saved!' if @train.save && !request.xhr?
    respond_with @train
  end

  # PATCH/PUT /trains/1
  def update
    @train.update(train_params)
    authorize @train
    flash[:notice] =  'The train was successfully updated!' if @train.update(train_params) && !request.xhr?
    respond_with @train
  end

  # DELETE /trains/1
  def destroy
    authorize @train
    redirect_to trains_url, notice: 'Train was successfully destroyed.'  if @train.destroy && !request.xhr?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_train
      @train = Train.find(params[:id])
    end

    def sort_column
      Train.all.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end


    # Only allow a trusted parameter "white list" through.
    def train_params
      params.require(:train).permit(:station_start, :station_finish, :train_number)
    end
end
