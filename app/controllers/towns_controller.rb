class TownsController < ApplicationController
  before_filter :set_town, only: [:show, :edit, :update, :destroy]
  autocomplete :town, :accent_city, :display_value => :twdata, :extra_data => [:city, :accent_city, :country]

  def admin_tw
    render layout: "application_empty_1"
  end

  def index
    @towns = Town.search(params[:search]).order(sort_column + " " + sort_direction)
    @towns = @towns.page(params[:page]).per(params[:per_page])
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
  end

  def show
    @airports = Airport.where(town_id: @town.id)
    @airports = @airports.page(params[:page]).per(params[:per_page])
    respond_with(@town)
  end

  def new
    @town = Town.new
    respond_with(@town)
  end

  def edit
  end

  def create
    @town = Town.new(params[:town])
    @town.save
    respond_with(@town)
  end

  def update
    @town.update_attributes(params[:town])
    respond_with(@town)
  end

  def destroy
    @town.destroy
    respond_with(@town)
  end

  def tw_dist
    @ap1 = Town.find(params[:start_ap])
    @ap2 = Town.find(params[:end_ap])
    @p1 = GeoPoint.new  @ap1.latitude.to_f, @ap1.longitude.to_f
    @p2 = GeoPoint.new  @ap2.latitude.to_f, @ap2.longitude.to_f
    @dist = @p1.distance_to(@p2)
  end

private
  def sort_column
    Town.column_names.include?(params[:sort]) ? params[:sort] : "country"
  end

  def set_town
    @town = Town.find(params[:id])
  end
end
