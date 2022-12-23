class FlightTypesController < ApplicationController
  before_action :set_flight_type, only: [:show, :edit, :update, :destroy]

  def index
    @flight_types = FlightType.all
    authorize FlightType
    respond_with(@flight_types)
  end

  def show
    authorize @flight_type
    respond_with(@flight_type)
  end

  def new
    @flight_type = FlightType.new
    authorize @flight_type
    respond_with(@flight_type)
  end

  def edit
    authorize @flight_type
  end

  def create
    @flight_type = FlightType.new(params[:flight_type])
    @flight_type.save
    flash[:notice] = 'The Flight_type was successfully created!' if @flight_type.save && !request.xhr?
    authorize @flight_type
    respond_with(@flight_type)
  end

  def update
    @flight_type.update(params[:flight_type])
    flash[:notice] = 'The Flight_type was successfully updated!' if @flight_type.update(params[:flight_type]) && !request.xhr?
    authorize @flight_type
    respond_with(@flight_type)
  end

  def destroy
    @flight_type.destroy
    authorize @flight_type
    respond_with(@flight_type)
  end

private
  def set_flight_type
    @flight_type = FlightType.find(params[:id])
  end

  def flight_type_params
    params.require(:flight_type).permit(:flight_type)
  end
end
