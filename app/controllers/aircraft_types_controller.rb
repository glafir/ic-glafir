class AircraftTypesController < ApplicationController
  before_action :set_aircraft_type, only: [:show, :edit, :update, :destroy]

  def index
    @aircraft_types = AircraftType.all
    authorize AircraftType
    respond_with(@aircraft_types)
  end

  def show
    authorize @aircraft_type
    respond_with(@aircraft_type)
  end

  def new
    @aircraft_type = AircraftType.new
    authorize @aircraft_type
    respond_with(@aircraft_type)
  end

  def edit
    authorize @aircraft_type
  end

  def create
    @aircraft_type = AircraftType.new(params[:aircraft_type])
    @aircraft_type.save
    flash[:notice] = "The aircraft_type was created!" if @aircraft_type.save && !request.xhr?
    authorize @aircraft_type
    respond_with(@aircraft_type)
  end

  def update
    @aircraft_type.update_attributes(params[:aircraft_type])
    flash[:notice] = "The aircraft_type was updated!" if @aircraft_type.update_attributes(params[:aircraft_type]) && !request.xhr?
    authorize @aircraft_type
    respond_with(@aircraft_type)
  end

  def destroy
    @aircraft_type.destroy
    authorize @aircraft_type
    respond_with(@aircraft_type)
  end

  private
  def set_aircraft_type
    @aircraft_type = AircraftType.find(params[:id])
  end

  def aircraft_type_params
    params.require(:aircraft_type).permit(:atype)
  end
end
