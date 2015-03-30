class AircompaniesController < ApplicationController
  before_filter :set_aircompany, only: [:show, :edit, :update, :destroy]
  autocomplete :aircompany, :airline_name_rus, :extra_data => [:iata_code]

  def admin_al
    render layout: "application_empty_1"
  end

  def index
    @aircompanies = Aircompany.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    respond_with(@aircompany)
  end

  def show
    @timetableaps = Timetableap.where(aircompany_id: params[:id]).order(:Flight_Number)
    @timetableap_subs = TimetableapSub.where(aircompany_id: params[:id]).order(:Flight_Number)
    respond_with(@aircompany)
  end
  
  def new
    @aircompany = Aircompany.new
    @airports = Airport.all
    respond_with(@aircompany)
  end

  def edit
    @airports = Airport.all
  end

  def create
    @aircompany = Aircompany.new(params[:aircompany])
    @aircompany.save
    respond_with(@aircompany)
  end

  def update
    @aircompany.update_attributes(params[:aircompany])
    respond_with(@aircompany)
  end

  def destroy
    @aircompany.destroy
    respond_with(@aircompany)
  end

private
  def sort_column
    Aircompany.column_names.include?(params[:sort]) ? params[:sort] : "Airline_name_rus"
  end

  def set_aircompany
    @aircompany = Aircompany.find(params[:id])
  end
end
