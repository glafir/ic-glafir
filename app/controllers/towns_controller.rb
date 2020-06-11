class TownsController < ApplicationController
  before_action :set_town, only: [:show, :edit, :update, :destroy]
  before_action :check_permissions, only: [:autocomplete_town_accent_city, :autocomplete_town_city_rus]
#  before_action :load_parent
#  autocomplete :town, :accent_city, :limit => 50, :display_value => :twdata, :extra_data => [:city, :accent_city, :country_iso, :latitude, :longitude]
#  autocomplete :town, :city_rus, :limit => 50, :display_value => :twdata, :extra_data => [:city, :accent_city, :country_iso, :latitude, :longitude]
   autocomplete :town, :city_rus
#  def autocomplete_town_city_rus
#    @towns = Town.autocomplete_town_city_rus(params[:q])
#    render text: @towns.to_a.map(&:serializable_hash)
#  end

  def admin_tw
    render layout: "application_empty_1"
  end

  def index
#    if params[:country_id].nil?
      @towns = Town.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
#    else
#      @country = Country.find(params[:country_id])
#      @towns = @country.towns.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
#    end
    authorize Town
    respond_with(@towns)
  end

  def to_s
    city
    accent_city
    city_rus
  end

  def show
    authorize @town
    @airports = @town.airports.page(params[:page]).per(params[:per_page])
    respond_with(@town)
  end

  def new
    @town = Town.new
    authorize @town
  end

  def edit
    authorize @town
  end

  def create
    @town = Town.new(town_params)
    authorize @town
    flash[:notice] = "The town  #{@town.id} was created!" if @town.save && !request.xhr?
    @flash_message_state_id = 401
    respond_with(@country, @town)
  end

  def update
    authorize @town
    @town.update_attributes(town_params)
    flash[:notice] = "The town  #{@town.id} was updated!" if @town.update_attributes(town_params) && !request.xhr?
    @flash_message_state_id = 402
    respond_with(@country, @town)
  end

  def destroy
    authorize @town
    @town.destroy
    redirect_to :back
  end

  def tw_dist
    authorize Town
    @ap1 = Town.find(params[:start_ap]) if params[:start_ap] != nil
    @ap2 = Town.find(params[:end_ap]) if params[:end_ap] != nil
    @dist = Airport.distance(@p1,@p2)
  end

private
  def sort_column
    Town.column_names.include?(params[:sort]) ? params[:sort] : "country_id"
  end

  def set_town
    @town = Town.find(params[:id])
  end

  def load_parent
    @country = Country.find(params[:country_id]) ? current_user.country : nil
  end


  def town_params
    params.require(:town).permit(:accent_city, :city, :country_iso, :country_id, :latitude, :longitude, :region, :city_rus)
  end
  protected

  def check_permissions
    authorize :town
  end
end
