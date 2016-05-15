class AircompaniesController < ApplicationController
  before_filter :set_aircompany, only: [:show, :edit, :update, :destroy]
  autocomplete :aircompany, :airline_name_rus, :extra_data => [:iata_code]
  before_filter :check_permissions, :only => [:admin_al, :autocomplete_aircompany_airline_name_rus]
  def admin_al
  end

  def index
    authorize :aircompany
    @aircompanies = Aircompany.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:limit])
    respond_with @aircompanies
  end

  def show
    authorize @aircompany
    @timetableaps = @aircompany.timetableaps.where(parent_id: nil).order(:Flight_Number).page(params[:page]).per(params[:per_page])
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
    @aircompany = Aircompany.new(params[:aircompany])
#    authorize @aircompany
    @aircompany.save
    flash[:notice] = "The aircompany #{@aircompany.id} was created!" if @aircompany.save && !request.xhr?
    respond_with @aircompany
  end

  def update
    authorize @aircompany
    @aircompany.update_attributes(params[:aircompany])
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
    Aircompany.column_names.include?(params[:sort]) ? params[:sort] : "airline_name_rus"
  end

  def set_aircompany
    @aircompany = Aircompany.find(params[:id])
  end

  protected

  def check_permissions
    authorize :aircompany
  end
end
