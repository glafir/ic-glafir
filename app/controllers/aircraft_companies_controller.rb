class AircraftCompaniesController < ApplicationController
  before_filter :set_aircraft_company, only: [:show, :edit, :update, :destroy]


  def index
    @aircraft_companies = AircraftCompany.all
    authorize AircraftCompany
    respond_with(@aircraft_companies)
  end

  def show
    authorize @aircraft_company
    respond_with(@aircraft_company)
  end

  def new
    @aircraft_company = AircraftCompany.new
    authorize @aircraft_company
    respond_with(@aircraft_company)
  end

  def edit
    authorize @aircraft_company
  end

  def create
    @aircraft_company = AircraftCompany.new(params[:aircraft_company])
    @aircraft_company.save
    flash[:notice] = "The aircraft_company was created!" if @aircraft_company.save && !request.xhr?
    authorize @aircraft_company
    respond_with(@aircraft_company)
  end

  def update
    @aircraft_company.update_attributes(params[:aircraft_company])
    flash[:notice] = "The aircraft_company was updated!" if @aircraft_company.update_attributes(params[:aircraft_company]) && !request.xhr?
    authorize @aircraft_company
    respond_with(@aircraft_company)
  end

  def destroy
    @aircraft_company.destroy
    authorize @aircraft_company
    respond_with(@aircraft_company)
  end

  private
  def set_aircraft_company
    @aircraft_company = AircraftCompany.find(params[:id])
  end
end
