class CountriesController < ApplicationController
  def index
    @countries = Country.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page])
  end

  # GET /countries/1
  # GET /countries/1.json
  def ap_show
    @country = Country.find(params[:id])
    @airports = Airport.where(iso_code: @country.country_iata_code).search_c(params[:search]).order(sort_column_a + " " + sort_direction).page(params[:page]).per(params[:per_page])
  end

  def tw_show
    @country = Country.find(params[:id])
    @towns = Town.where(country: @country.country_iata_code.to_s.upcase).search(params[:search]).order(sort_column_t + " " + sort_direction).page(params[:page]).per(params[:per_page])
  end


  # GET /countries/new
  # GET /countries/new.json
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render json: @country, status: :created, location: @country }
      else
        format.html { render action: "new" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.json
  def update
    @country = Country.find(params[:id])

    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to countries_url }
      format.json { head :no_content }
    end
  end

private
  def sort_column
    Country.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_column_a
    Airport.column_names.include?(params[:sort]) ? params[:sort] : "city_rus"
  end

  def sort_column_t
    Town.column_names.include?(params[:sort]) ? params[:sort] : "city"
  end
end
