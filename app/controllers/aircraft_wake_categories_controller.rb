class AircraftWakeCategoriesController < ApplicationController
  before_filter :set_aircraft_wake_category, only: [:show, :edit, :update, :destroy]

  def index
    @aircraft_wake_categories = AircraftWakeCategory.all
    respond_with(@aircraft_wake_category)
  end

  def show
    respond_with(@aircraft_wake_category)
  end

  def new
    @aircraft_wake_category = AircraftWakeCategory.new
    respond_with(@aircraft_wake_category)
  end

  def edit
  end

  def create
    @aircraft_wake_category = AircraftWakeCategory.new(params[:aircraft_wake_category])
    @aircraft_wake_category.save
    respond_with(@aircraft_wake_category)
  end

  def update
    @aircraft_wake_category.update_attributes(params[:aircraft_wake_category])
    respond_with(@aircraft_wake_category)
  end

  def destroy
    @aircraft_wake_category.destroy
    respond_with(@aircraft_wake_category)
  end

private
  def set_aircraft_wake_category
    @aircraft_wake_category = AircraftWakeCategory.find(params[:id])
  end
end
