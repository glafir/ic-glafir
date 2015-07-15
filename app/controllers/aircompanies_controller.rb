class AircompaniesController < ApplicationController
  before_filter :set_aircompany, only: [:show, :edit, :update, :destroy]
  autocomplete :aircompany, :airline_name_rus, :extra_data => [:iata_code]
  before_filter :check_permissions, :only => [:admin_al, :autocomplete_aircompany_airline_name_rus]
  def admin_al
    render layout: "application_empty_1"
#    respond_to do |format|
#      format.html { render template: 'aircompanies/admin_al' }
#      format.js { render template: 'aircompanies/admin_al', layout: "application_empty_1" }
#    end
  end

  def index
    @aircompanies = Aircompany.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
    authorize Aircompany
    respond_with @aircompanies
  end

  def show
    @timetableaps = Timetableap.where(aircompany_id: params[:id]).order(:Flight_Number).page(params[:page]).per(params[:per_page])
    @timetableap_subs = TimetableapSub.where(aircompany_id: params[:id]).order(:Flight_Number).page(params[:sub_page]).per(params[:per_sub_page])
    authorize @aircompany
    respond_with @aircompany
  end
  
  def new
    @aircompany = Aircompany.new
    @airports = Airport.all
    authorize @aircompany
    respond_with @aircompany
  end

  def edit
    @airports = Airport.all
    authorize @aircompany
  end

  def create
    @aircompany = Aircompany.new(params[:aircompany])
    @aircompany.save
    flash[:notice] = "The aircompany was created!" if @aircompany.save && !request.xhr?
    authorize @aircompany
    respond_with @aircompany
  end

  def update
    @aircompany.update_attributes(params[:aircompany])
    flash[:notice] = "The aircompany was updated!" if @aircompany.save && !request.xhr?
    authorize @aircompany
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
