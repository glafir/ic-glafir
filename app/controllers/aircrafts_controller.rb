class AircraftsController < ApplicationController
  before_action :set_aircraft, only: [:show, :edit, :update, :destroy]
  autocomplete :aircraft, :aircraft_model

  def index
    @aircrafts = Aircraft.all
    authorize Aircraft
    respond_with(@aircrafts)
  end

  def show
    authorize @aircraft
    respond_with(@aircraft)
  end

  def new
    @aircraft = Aircraft.new
    authorize @aircraft
    respond_with(@aircraft)
  end

  def edit
    authorize @aircraft
  end

  def create
    @aircraft = Aircraft.new(params[:aircraft])
    authorize @aircraft
    @aircraft.save
    flash[:notice] = "The aircraft was created!" if @aircraft.save && !request.xhr?
    respond_with(@aircraft)
  end

  def update
    @aircraft.updates(params[:aircraft])
    authorize @aircraft
    flash[:notice] = "The aircraft was updated!" if @aircraft.updates(params[:aircraft]) && !request.xhr?
    respond_with(@aircraft)
  end

  def destroy
    authorize @aircraft
    @aircraft.destroy
    respond_with(@aircraft)
  end

private
  def set_aircraft
    @aircraft = Aircraft.find(params[:id])
  end

  def aircraft_params
    params.require(:aircraft).permit(:aircraft_iata_code, :aircraft_icao_code, :aircraft_maxspeed, :aircraft_model, :aircraft_seats, :aircraft_type_id, :aircraft_wake_category_id, :aircraft_webinfo, :aircraft_company_id)
  end
end
