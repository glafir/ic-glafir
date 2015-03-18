class AircraftCompaniesController < ApplicationController
  # GET /aircraft_companies
  # GET /aircraft_companies.json
  def index
    @aircraft_companies = AircraftCompany.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aircraft_companies }
    end
  end

  # GET /aircraft_companies/1
  # GET /aircraft_companies/1.json
  def show
    @aircraft_company = AircraftCompany.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aircraft_company }
    end
  end

  # GET /aircraft_companies/new
  # GET /aircraft_companies/new.json
  def new
    @aircraft_company = AircraftCompany.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aircraft_company }
    end
  end

  # GET /aircraft_companies/1/edit
  def edit
    @aircraft_company = AircraftCompany.find(params[:id])
  end

  # POST /aircraft_companies
  # POST /aircraft_companies.json
  def create
    @aircraft_company = AircraftCompany.new(params[:aircraft_company])

    respond_to do |format|
      if @aircraft_company.save
        format.html { redirect_to @aircraft_company, notice: 'Aircraft company was successfully created.' }
        format.json { render json: @aircraft_company, status: :created, location: @aircraft_company }
      else
        format.html { render action: "new" }
        format.json { render json: @aircraft_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aircraft_companies/1
  # PUT /aircraft_companies/1.json
  def update
    @aircraft_company = AircraftCompany.find(params[:id])

    respond_to do |format|
      if @aircraft_company.update_attributes(params[:aircraft_company])
        format.html { redirect_to @aircraft_company, notice: 'Aircraft company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aircraft_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aircraft_companies/1
  # DELETE /aircraft_companies/1.json
  def destroy
    @aircraft_company = AircraftCompany.find(params[:id])
    @aircraft_company.destroy

    respond_to do |format|
      format.html { redirect_to aircraft_companies_url }
      format.json { head :no_content }
    end
  end
end
