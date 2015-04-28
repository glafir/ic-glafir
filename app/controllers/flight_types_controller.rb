class FlightTypesController < ApplicationController
  before_filter :set_flight_type, only: [:show, :edit, :update, :destroy]

  def index
    @flight_types = FlightType.all
    respond_with(@flight_types)
  end

  def show
    respond_with(@flight_type)
  end

  def new
    @flight_type = FlightType.new
    respond_with(@flight_type)
  end

  def edit
  end

  def create
    @flight_type = FlightType.new(params[:flight_type])
    @flight_type.save
    flash[:notice] = 'The Flight_type was successfully created!' if @flight_type.save && !request.xhr?
    respond_with(@flight_type)
  end

  def update
    @flight_type.update_attributes(params[:flight_type])
    flash[:notice] = 'The Flight_type was successfully updated!' if @flight_type.update_attributes(params[:flight_type]) && !request.xhr?
    respond_with(@flight_type)
  end

  def destroy
    @flight_type.destroy
    respond_with(@flight_type)
  end

private
  def set_flight_type
    @flight_type = FlightType.find(params[:id])
  end
end
