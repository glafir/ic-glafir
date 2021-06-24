class AircompaniesController < ApplicationController
  before_action :set_aircompany, only: [:show, :edit, :update, :destroy]
#  autocomplete :aircompany, :airline_name_rus, :extra_data => [:iata_code]
  autocomplete  :aircompany, :airline_name_rus
  before_action :check_permissions, :only => [:autocomplete_aircompany_airline_name_rus, :autocomplete_airline_name_rus]

  def admin_al
    authorize :aircompany
  end

  def index
    authorize :aircompany
    @aircompanies = Aircompany.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    respond_with @aircompanies
  end

  def show
    authorize @aircompany
    @timetableaps = @aircompany.timetableaps.where(parent_id: nil).order(:Flight_Number).page(params[:page]).per(params[:per_page])
    @hubs = @aircompany.aphubs.where(hub_status:1)
    @agencies = @aircompany.aphubs.where(hub_status:0)
    respond_with @aircompany
  end
  
  def new
    @aircompany = Aircompany.new
    authorize @aircompany
    @airports = Airport.all
    respond_with @aircompany
  end

  def edit
    authorize @aircompany
    @airports = Airport.all
  end

  def create
    authorize :aircompany
    @aircompany = Aircompany.new(aircompany_params)
#    authorize @aircompany
    @aircompany.save
    flash[:notice] = "The aircompany #{@aircompany.id} was created!" if @aircompany.save && !request.xhr?
    respond_with @aircompany
  end

  def update
    authorize @aircompany
    @aircompany.update_attributes(aircompany_params)
    flash[:notice] = "The aircompany #{@aircompany.id} was updated!" if @aircompany.save && !request.xhr?
    respond_with @aircompany
  end

  def destroy
    @aircompany.destroy
    authorize @aircompany
    respond_with @aircompany
  end

private

  def sort_column
#    Aircompany.column_names.include?(params[:sort]) ? params[:sort] : "airline_name_rus"
    params[:sort] || "airline_name_rus"
  end

  def set_aircompany
    @aircompany = Aircompany.find(params[:id])
  end

  def aircompany_params
    params.require(:aircompany).permit(:awb_prefix, :airline_name_eng, :airline_name_rus, :airport_id, :iata_code, :icao_code, :al_start, :al_finish, :country_id, :manager_id, :avatar, :avatar_cache)
  end

  protected

  def check_permissions
    authorize :aircompany
  end
end
