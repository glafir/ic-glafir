class AircraftsController < ApplicationController
  before_filter :set_aircraft, only: [:show, :edit, :update, :destroy]
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
    @aircraft.save
    flash[:notice] = "The aircraft was created!" if @aircraft.save && !request.xhr?
    authorize @aircraft
    respond_with(@aircraft)
  end

  def update
    @aircraft.update_attributes(params[:aircraft])
    flash[:notice] = "The aircraft was updated!" if @aircraft.update_attributes(params[:aircraft]) && !request.xhr?
    authorize @aircraft
    respond_with(@aircraft)
  end

  def destroy
    @aircraft.destroy
    authorize @aircraft
    respond_with(@aircraft)
  end

private
  def set_aircraft
    @aircraft = Aircraft.find(params[:id])
  end
end
