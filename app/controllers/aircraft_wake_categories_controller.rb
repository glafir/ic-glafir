class AircraftWakeCategoriesController < ApplicationController
  before_action :set_aircraft_wake_category, only: [:show, :edit, :update, :destroy]

  def index
    @aircraft_wake_categories = AircraftWakeCategory.all
    authorize AircraftWakeCategory
    respond_with(@aircraft_wake_categories)
  end

  def show
    authorize @aircraft_wake_category
    respond_with(@aircraft_wake_category)
  end

  def new
    @aircraft_wake_category = AircraftWakeCategory.new
    authorize @aircraft_wake_category
    respond_with(@aircraft_wake_category)
  end

  def edit
    authorize @aircraft_wake_category
  end

  def create
    @aircraft_wake_category = AircraftWakeCategory.new(params[:aircraft_wake_category])
    @aircraft_wake_category.save
    flash[:notice] = "The aircraft_wake_category was created!" if @aircraft_wake_category.save && !request.xhr?
    authorize @aircraft_wake_category
    respond_with(@aircraft_wake_category)
  end

  def update
    @aircraft_wake_category.update_attributes(params[:aircraft_wake_category])
    flash[:notice] = "The aircraft_wake_category was updated!" if @aircraft_wake_category.update_attributes(params[:aircraft_wake_category]) && !request.xhr?
    authorize @aircraft_wake_category
    respond_with(@aircraft_wake_category)
  end

  def destroy
    @aircraft_wake_category.destroy
    authorize @aircraft_wake_category
    respond_with(@aircraft_wake_category)
  end

private
  def set_aircraft_wake_category
    @aircraft_wake_category = AircraftWakeCategory.find(params[:id])
  end

  def aircraft_wake_category_params
    params.require(:aircraft_wake_category).permit(:category)
  end
end
