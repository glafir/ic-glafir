class AphubsController < ApplicationController
  before_action :set_aphub, only: [:show, :edit, :update, :destroy]

  def admin_aphub
    authorize :Aphub
  end

  def index
    @aphubs = Aphub.all
    authorize Aphub
    respond_with(@aphubs)
  end

  def show
    authorize @aphub
    respond_with(@aphub)
  end

  def new
    @aphub = Aphub.new
    authorize @aphub
    respond_with(@aphub)
  end

  def edit
    authorize @aphub
  end

  def create
    @aphub = Aphub.new(params[:aphub])
    flash[:notice] = "The aphub was saved!" if @aphub.save && !request.xhr?
    authorize @aphub
    respond_with(@aphub)
  end

  def update
    flash[:notice] = "The aphub was updated!" if @aphub.updates(params[:aphub]) && !request.xhr?
    authorize @aphub
    respond_with(@aphub)
  end

  def destroy
    @aphub.destroy
    authorize @aphub
    respond_with(@aphub)
  end

  private
  def set_aphub
    @aphub = Aphub.find(params[:id])
  end

  def aphub_params
    params.require(:aphub).permit(:aircompany_id, :airport_id, :hub_type)
  end
end
