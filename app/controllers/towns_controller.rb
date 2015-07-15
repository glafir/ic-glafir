class TownsController < ApplicationController
  before_filter :set_town, only: [:show, :edit, :update, :destroy]
  autocomplete :town, :accent_city, :display_value => :twdata, :extra_data => [:city, :accent_city, :country_iso, :latitude, :longitude]
  before_filter :check_permissions, only: :autocomplete_town_accent_city

  def admin_tw
    render layout: "application_empty_1"
  end

  def index
    @towns = Town.search(params[:search]).order(sort_column + " " + sort_direction)
    @towns = @towns.page(params[:page]).per(params[:per_page])
    authorize Town
    respond_with(@towns)
  end

  def apToTw
    @airports = Airport.all
    @airports.each do |airport|
      @apkey = Apkey.new
      @apkey.id = airport.id if apkey.id.blank?
      @apkey.airport_id = airport.id if apkey.airport_id.blank?
      @apkey.save
    end
  authorize Airport
  end

  def show
    @airports = Airport.where(town_id: @town.id)
    @airports = @airports.page(params[:page]).per(params[:per_page])
    authorize @town
    respond_with(@town)
  end

  def new
    @town = Town.new
    authorize @town
    respond_with(@town)
  end

  def edit
    authorize @town
  end

  def create
    @town = Town.new(params[:town])
    @town.save
    authorize @town
    respond_with(@town)
  end

  def update
    @town.update_attributes(params[:town])
    authorize @town
    respond_with(@town)
  end

  def destroy
    @town.destroy
    authorize @town
    respond_with(@town)
  end

  def tw_dist
    @ap1 = Town.find(params[:start_ap]) if params[:start_ap] != nil
    @ap2 = Town.find(params[:end_ap]) if params[:end_ap] != nil
    if @ap1 != nil || @ap2 != nil
      @p1 = GeoPoint.new  @ap1.latitude.to_f, @ap1.longitude.to_f
      @p2 = GeoPoint.new  @ap2.latitude.to_f, @ap2.longitude.to_f
      @dist = @p1.distance_to(@p2)
    end
    authorize Town
  end

private
  def sort_column
    Town.column_names.include?(params[:sort]) ? params[:sort] : "country_id"
  end

  def set_town
    @town = Town.find(params[:id])
  end

  protected

  def check_permissions
    authorize :town
  end
end
