class AphubsController < ApplicationController
  before_filter :set_aphub, only: [:show, :edit, :update, :destroy]

  def index
    @aphubs = Aphub.all
    respond_with(@aphubs)
  end

  def show
    respond_with(@aphub)
  end

  def new
    @aphub = Aphub.new
    respond_with(@aphub)
  end

  def edit
  end

  def create
    @aphub = Aphub.new(params[:aphub])
    @aphub.save
    flash[:notice] = "The aphub was saved!" if @aphub.save && !request.xhr?
    respond_with(@aphub)
  end

  def update
    @aphub.update_attributes(params[:aphub])
    flash[:notice] = "The aphub was updated!" if @aphub.update_attributes(params[:aphub]) && !request.xhr?
    respond_with(@aphub)
  end

  def destroy
    @aphub.destroy
    respond_with(@aphub)
  end

  private
  def set_aphub
    @aphub = Aphub.find(params[:id])
  end
end
