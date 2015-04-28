class CountriesController < ApplicationController
  before_filter :set_country, only: [:show, :ap_show, :tw_show, :edit, :update, :destroy]
  before_filter :set_airports, only: [:ap_show, :show]

  def index
    @countries = Country.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page])
    respond_with(@countries)
  end

  def ap_show
#    @airports = @country.airports.search(params[:search]).order(sort_column_a + " " + sort_direction).page(params[:page]).per(params[:per_page])
    respond_with(@country)
  end

  def tw_show
    @towns = Town.where(country: @country.country_iata_code.to_s.upcase).search(params[:search]).order(sort_column_t + " " + sort_direction).page(params[:page]).per(params[:per_page])
    respond_with(@country)
  end

  def show
#    @airports = @country.airports.search(params[:search]).order(sort_column_a + " " + sort_direction).page(params[:page]).per(params[:per_page])
    respond_with(@country)
  end

  def new
    @country = Country.new
    respond_with(@country)
  end

  def edit
  end

  def create
    @country = Country.new(params[:country])
    @country.save
    flash[:notice] = 'The Country was successfully created!' if @country.save && !request.xhr?
    respond_with(@country)
  end

  def update
    @country.update_attributes(params[:country])
    flash[:notice] = 'The Country was successfully updated!' if @country.update_attributes(params[:country]) && !request.xhr?
    respond_with(@country)
  end

  def destroy
    @country.destroy
    respond_with(@country)
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

  def set_country
    @country = Country.find(params[:id])
  end

  def set_airports
    @airports = @country.airports.search(params[:search]).order(sort_column_a + " " + sort_direction).page(params[:page]).per(params[:per_page])
  end
end
