class AirportsController < ApplicationController
#include ActionView::Helpers::UrlHelper
before_action :set_airport, only: [:show, :edit, :update, :destroy, :aptt, :tablo, :apload, :ap_stats]
#layout "without_html", :only => [:tablo]
autocomplete :airport, :city_rus, :limit => 50, :extra_data => [:name_rus, :city_eng, :iata_code], :display_value => :apdata
#autocomplete :airport, :city_rus
#autocomplete :airport, :city_rus, :limit => 50, :extra_data => [:name_rus, :city_eng, :iata_code], :display_value => :apdata
before_action :check_permissions, only: :autocomplete_airport_city_rus
#caches_page :show, :new

#  def autocomplete_airport_name_rus
#    iata_code = params[iata_code]
#    town_id = params[:town_id]
#    name_rus = params[:name_rus]
#    airports = Airport.where('name_rus LIKE ? OR iata_code LIKE ?', brand_id, country, "%#{term}%").order(:name).all
#    render :json => airports.map { |airport| {:id => airport.id, :label => airport.name_eng, :value => airport.name_rus} }
#    authorize Airport
#
#    render :nothing => true
#   end

  def ap_maps
    authorize :airport
  end

  def ap_stats
    authorize :airport
  end

  def apload
    authorize @airport
    @timetableaps = Timetableap.where(airport_start_id: @airport.id).where("s#{@wday} = ?",1)
    if params[:apload] == 'out'
      @title = "Загруженность аэропорта #{@airport.name_rus} вылет"
      tbody_tablo_out
    elsif params[:apload] == 'in'
      @title = "Загруженность аэропорта #{@airport.name_rus} прилёт"
      tbody_tablo_in
    else
      @title = "Загруженность аэропорта #{@airport.name_rus} общая"
      tbody_tablo_out
      @timetableaps1 = @timetableaps
      tbody_tablo_in
      @timetableaps2 = @timetableaps
      @timetableaps = @timetableaps1 + @timetableaps2
    end
  end

  def search_ap_circle
    authorize :airport
  end

  def admin_ap
    authorize :airport
    respond_with(@airports)
  end

  def weather
    authorize :airport
  end

  def index
    authorize :airport
    @airports = Airport.search(params[:search]).order(sort_column + " " + sort_direction).order(:name_rus).order(:name_eng).page(params[:page]).per(params[:limit])
    respond_with(@airports)
  end

  def show
    @aircompanies = @airport.aircompanies.page(params[:page]).per(params[:per_page])
    authorize @airport
    respond_with(@airport)
  end

  def aptt
    authorize @airport
    respond_with(@airport)
  end

  def new
    @airport = Airport.new
    authorize @airport
    respond_with(@airport)
  end

  def edit
     authorize @airport
  end

  def create
    @airport = Airport.new(airport_params)
    authorize @airport
    flash[:notice] = "The airport #{@airport.id} was created!" if @airport.save && !request.xhr?
    respond_with(@airport)
  end

  def update
    authorize @airport
    flash[:notice] = "The airport  #{@airport.id} was updated!" if @airport.update_attributes(airport_params) && !request.xhr?
    respond_with(@airport)
  end

  def destroy
    authorize @airport
    @airport.destroy
    respond_with(@airport)
  end
  
  def tablo
    Time.zone = @airport.time_zone
    if params[:apt] == 'out'
      @tablo = "Табло вылета аэропорта #{view_context.link_to @airport.name_rus, airport_path(@airport)} на сегодня #{Time.now.in_time_zone(@airport.time_zone).to_s}"
      tbody_tablo_out
    elsif params[:apt] == 'in'
      @tablo = "Табло прилёта аэропорта #{view_context.link_to @airport.name_rus, airport_path(@airport)} на сегодня #{Time.zone.now.to_s(:short)}"
      tbody_tablo_in
    else
      @tablo = "Расписание аэропорта #{view_context.link_to @airport.name_rus, airport_path(@airport)} на сегодня #{Time.zone.now.to_s(:short)}"
      tbody_tablo_out
      @timetableaps1 = @timetableaps
      tbody_tablo_in
      @timetableaps2 = @timetableaps
      @timetableaps = @timetableaps1 + @timetableaps2
    end
    authorize @airport
    if  params[:size] == 'full'
      render "tablo"
    elsif  params[:size] == 'short'
      render "tablo_short"
    end
#    respond_with(@airport)
  end

  def ap_dist
    authorize :airport
    @ap1 = Airport.find(params[:start_ap]) if params[:start_ap] != nil
    @ap2 = Airport.find(params[:end_ap]) if params[:end_ap] != nil
    @dist = Airport.ap_distance(@ap1, @ap2)
  end
  
private
  def sort_column
    Airport.column_names.include?(params[:sort]) ? params[:sort] : "name_rus"
  end  

  def tbody_tablo_out
    Time.zone = @airport.time_zone
    @timetableaps = @airport.timetableaps_out.stoday
    @timetableaps = @timetableaps.search_al(params[:search_al])
#    @timetableaps1 = @timetableaps.childs.search_al(params[:search_al])
    @timetableaps = @timetableaps.where(parent_id:nil)
    @timetableaps = @timetableaps.search_endtw(params[:search_tw])
    @timetableaps = @timetableaps.search_endcountry(params[:country])
    @airlines = Aircompany.where(:id => @timetableaps.select(:aircompany_id).group(:aircompany_id))
    @towns = Town.where(:id => Airport.select(:town_id).where(:id => @timetableaps.select(:airport_finish_id)))
    @countries = Country.where(:id => Airport.select(:country_id).where(:id => @timetableaps.select(:airport_finish_id)))
    @timetableaps.each do |tt|
      tt.s_ap = tt.airport_start
      tt.f_ap = tt.airport_finish
#      if tt.timeStart.hour < 24 - (DateTime.current.in_time_zone(@airport_time_zone).utc_offset / 3600)
#        tt.timeIN = tt.timeStart.change(:year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
#      else
#        tt.timeIN = tt.timeStart.change(:year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
#      end
      tt.timeIN = tt.time_start
      tt.bgcolor_apload = "#9c0a0a"
      if tt.timeIN < Time.zone.now.utc
        tt.fstatus = "Вылетел"
        tt.bgcolor = "success"
      elsif tt.timeIN < Time.zone.now.utc+15.minute and tt.timeIN > Time.zone.now.utc
        tt.fstatus = "Выход<br />закрыт"
        tt.bgcolor = "danger"
      elsif tt.timeIN < Time.zone.now.utc+40.minute and tt.timeIN > Time.zone.now.utc+15.minute
        tt.fstatus = "Посадка"
        tt.bgcolor = "warning"
      elsif tt.timeIN < Time.zone.now.utc+4.hour and tt.timeIN > Time.zone.now.utc+40.minute
        tt.fstatus = "регистрация"
        tt.bgcolor = "info"
      else
        tt.fstatus = "Ожидается<br />вылет"
        tt.bgcolor = "default"
      end
    end
  end

  def tbody_tablo_in
    Time.zone = @airport.time_zone
    @timetableaps = @airport.timetableaps_in.etoday.where(parent_id:nil)
    @airlines = Aircompany.where(:id => @timetableaps.select(:aircompany_id).group(:aircompany_id))
    @timetableaps = @timetableaps.search_starttw(params[:search_tw])
    @timetableaps = @timetableaps.search_al(params[:search_al])
    @timetableaps = @timetableaps.search_startcountry(params[:country])
    @towns = Town.where(:id => Airport.select(:town_id).where(:id => @timetableaps.select(:airport_start_id)))
    @countries = Country.where(:id => Airport.select(:country_id).where(:id => @timetableaps.select(:airport_start_id)))
    @timetableaps.each do |tt|
      tt.f_ap = tt.airport_start
      tt.s_ap = tt.airport_finish
#      if tt.timeEnd.hour < 24 - (Time.zone.now.utc_offset / 3600)
#        tt.timeIN = tt.timeEnd.change(:year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
#      else
#        tt.timeIN = tt.timeEnd.change(:year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
#      end
      tt.timeIN = tt.time_finish
      tt.bgcolor_apload = "#0B3762"
      if tt.timeIN < Time.zone.now
        tt.fstatus = "Прибыл"
        tt.bgcolor = "primary"
      else
        tt.fstatus = "Ожидается<br />прибытие"
        tt.bgcolor = "default"
      end
    end
  end

  def tbody_tablo 
  end

  def set_airport
    @airport = Airport.find(params[:id])
  end

  def airport_params
    params.require(:airport).permit(:Dist_to_town, :Terminals, :TerminalsColl, :city_eng, :city_rus, :email, :fax, :gmt_offset, :iata_code, :icao_code, :iso_code, :latitude, :longitude, :name_eng, :name_rus, :phone, :runnway_coll, :runway_elevation, :runway_length, :website, :town_id, :aircompanies_count, :country_id, :time_zone, :airport_state_id, :weather_state)
  end
  protected

  def check_permissions
    authorize :airport
  end
end
