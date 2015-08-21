class CountriesController < ApplicationController
  before_filter :set_country, only: [:show, :ap_show, :al_show, :tw_show, :edit, :update, :destroy]
  before_filter :set_airports, only: [:ap_show, :show]
  before_filter :set_towns, only: [:tw_show, :show]
  before_filter :set_airlines, only: [:al_show, :show]

  def index
    @countries = Country.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page])
    authorize Country
    respond_with(@countries)
  end

  def ap_show
    respond_with(@country)
    authorize @country
  end

  def tw_show
    authorize @country
    respond_with(@country)
  end

  def al_show
    authorize @country
    respond_with(@country)
  end

  def show
    authorize @country
    respond_with(@country)
  end

  def new
    @country = Country.new
    authorize @country
    respond_with(@country)
  end

  def edit
    authorize @country
  end

  def create
    @country = Country.new(params[:country])
    @country.save
    flash[:notice] = 'The Country was successfully created!' if @country.save && !request.xhr?
    authorize @country
    respond_with(@country)
  end

  def update
    @country.update_attributes(params[:country])
    flash[:notice] = 'The Country was successfully updated!' if @country.update_attributes(params[:country]) && !request.xhr?
    authorize @country
    respond_with(@country)
  end

  def destroy
    @country.destroy
    authorize @country
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

  def sort_column_al
    Aircompany.column_names.include?(params[:sort]) ? params[:sort] : "airport_id"
  end

  def set_country
    @country = Country.find(params[:id])
  end

  def set_airports
    @airports = @country.airports.search(params[:search]).order(sort_column_a + " " + sort_direction).page(params[:page]).per(params[:ap_limit])
  end
  def set_towns
    @towns = @country.towns.search(params[:search]).order(sort_column_a + " " + sort_direction).page(params[:page]).per(params[:tw_limit])
  end

  def set_airlines
    @aircompanies = @country.aircompanies.search(params[:search]).order(sort_column_al + " " + sort_direction).page(params[:page]).per(params[:al_limit])
  end
end
