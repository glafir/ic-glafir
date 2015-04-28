class AircraftTypesController < ApplicationController
  before_filter :set_aircraft_type, only: [:show, :edit, :update, :destroy]

  def index
    @aircraft_types = AircraftType.all
    respond_with(@aircraft_types)
  end

  def show
    respond_with(@aircraft_type)
  end

  def new
    @aircraft_type = AircraftType.new
    respond_with(@aircraft_type)
  end

  def edit
  end

  def create
    @aircraft_type = AircraftType.new(params[:aircraft_type])
    @aircraft_type.save
    flash[:notice] = "The aircraft_type was created!" if @aircraft_type.save && !request.xhr?
    respond_with(@aircraft_type)
  end

  def update
    @aircraft_type.update_attributes(params[:aircraft_type])
    flash[:notice] = "The aircraft_type was updated!" if @aircraft_type.update_attributes(params[:aircraft_type]) && !request.xhr?
    respond_with(@aircraft_type)
  end

  def destroy
    @aircraft_type.destroy
    respond_with(@aircraft_type)
  end

  private
  def set_aircraft_type
    @aircraft_type = AircraftType.find(params[:id])
  end
end
