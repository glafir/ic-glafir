class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :ap_show, :ap_show_ajax, :al_show, :tw_show, :edit, :update, :destroy]
  before_action :set_airports, only: [:ap_show, :ap_show_ajax, :show]
  before_action :set_towns, only: [:tw_show, :show]
  before_action :set_airlines, only: [:al_show, :show]

  def index
    @countries = Country.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    authorize Country
    respond_with(@countries)
  end

  def ap_show
    authorize @country
  end

  def ap_show_ajax
    authorize @country
    result = {}
    result["airports"] = @airports
    
    if (params[:page].to_i + 1) * ((params[:limit]).nil? ? 30 : params[:limit]) < @airports.size
      result['page'] = params[:page].to_i + 1
    end
    render json: result
  end

  def tw_show
    authorize @country
  end

  def al_show
    authorize @country
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
    Country.column_names.include?(params[:sort]) ? params[:sort] : "country_name"
  end

  def sort_column_a
    Airport.column_names.include?(params[:sort]) ? params[:sort] : "city_rus"
  end

  def sort_column_t
    Town.column_names.include?(params[:sort]) ? params[:sort] : "city"
  end

  def sort_column_al
    Aircompany.column_names.include?(params[:sort]) ? params[:sort] : "airline_name_rus"
  end

  def set_country
    @country = Country.find(params[:id])
  end

  def set_airports
    @airports = @country.airports.search(params[:search]).order(sort_column_a + " " + sort_direction).order(:name_rus).order(:name_eng).page(params[:page]).per(params[:limit])
    params[:page] = 1.to_i if params[:page].nil?
    params[:page] = params[:page].to_i + 1.to_i
  end

  def set_towns
    @towns = @country.towns.search(params[:search]).order(sort_column_a + " " + sort_direction).page(params[:page]).per(params[:limit])
    params[:page] = 1.to_i if params[:page].nil?
    params[:page] = params[:page].to_i + 1.to_i
  end

  def set_airlines
    @aircompanies = @country.aircompanies.search(params[:search]).order(sort_column_al + " " + sort_direction).page(params[:page]).per(params[:limit])
    params[:page] = 1.to_i if params[:page].nil?
    params[:page] = params[:page].to_i + 1.to_i
  end

  def country_params
    params.require(:country).permit(:country_iata_code, :country_icao_code, :country_name, :country_number)
  end
end
