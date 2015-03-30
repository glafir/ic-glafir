class AircraftCompaniesController < ApplicationController
  before_filter :set_aircraft_company, only: [:show, :edit, :update, :destroy]


  def index
    @aircraft_companies = AircraftCompany.all
    respond_with(@aircraft_company)
  end

  def show
    respond_with(@aircraft_company)
  end

  def new
    @aircraft_company = AircraftCompany.new
    respond_with(@aircraft_company)
  end

  def edit
  end

  def create
    @aircraft_company = AircraftCompany.new(params[:aircraft_company])
    @aircraft_company.save
    respond_with(@aircraft_company)
  end

  def update
    @aircraft_company.update_attributes(params[:aircraft_company])
    respond_with(@aircraft_company)
  end

  def destroy
    @aircraft_company.destroy
    respond_with(@aircraft_company)
  end

  private
  def set_aircraft_company
    @aircraft_company = AircraftCompany.find(params[:id])
  end
end
