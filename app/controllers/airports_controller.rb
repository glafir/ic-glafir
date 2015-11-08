# -*- encoding : utf-8 -*-
class AirportsController < ApplicationController
before_filter :set_airport, only: [:show, :edit, :update, :destroy, :aptt, :tablo]
#layout "without_html", :only => [:tablo]
autocomplete :airport, :name_rus, :limit => 50, :extra_data => [:city_rus, :city_eng, :iata_code], :display_value => :apdata
before_filter :check_permissions, only: :autocomplete_airport_name_rus

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

  def admin_ap
    render layout: "application_empty_1"
    authorize :airport
  end

  def index
    @airports = Airport.search(params[:search]).order(sort_column + " " + sort_direction).order(:name_rus).order(:name_eng).page(params[:page]).per(params[:limit])
    authorize Airport
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

  def city
    @airports = Airport.where(city_eng: params[:city_eng])
    @airports = @airports.paginate :page => params[:page], :order => 'name_rus'
    authorize Airport
    respond_with(@airport)
  end

  def new
    @airport = Airport.new
    @apkey = Apkey.new
    authorize @airport
    respond_with(@airport)
  end

  def edit
     authorize @airport
  end

  def create
    @airport = Airport.new(params[:airport])
    @apkey = Apkey.new
    authorize @airport
      if @airport.save
        @apkey.id = @airport.id
        @apkey.airport_id = @airport.id
        @apkey.save
        flash[:notice] = "The airport #{@airport.id} was created!" if @apkey.save && !request.xhr?
      end
    respond_with(@airport)
  end

  def update
    @airport.update_attributes(params[:airport])
    flash[:notice] = "The airport  #{@airport.id} was updated!" if @airport.update_attributes(params[:airport]) && !request.xhr?
    authorize @airport
    respond_with(@airport)
  end

  def destroy
    @airport.destroy
    authorize @airport
    respond_with(@airport)
  end
  
  def tablo
    Time.zone = @airport.time_zone
    @wday = Time.zone.now.strftime'%w'.to_s
    if params[:apt] == 'out'
      @tablo = "Табло вылета"
      tbody_tablo_out
      @timetableaps = @timetableaps + @timetableap_subs
    elsif params[:apt] == 'in'
      @tablo = "Табло прилёта"
      tbody_tablo_in
      @timetableaps = @timetableaps + @timetableap_subs
    else
      tbody_tablo_out
      @tablo = "Расписание на сегодня #{Time.zone.now.to_s(:short)}"
      @timetableaps1 = @timetableaps + @timetableap_subs
      tbody_tablo_in
      @timetableaps2 = @timetableaps + @timetableap_subs
      @timetableaps = @timetableaps1 + @timetableaps2
    end

## ----Для интерактивного селекта---------
#    @timetableaps = Timetableap.select("*,(select name_rus from airports where airports.id = timetableaps.#{@w_end}) as aprus,(select city_rus from airports where airports.id = timetableaps.#{@w_end}) as rus").where("#{@w_start} = ?", params[:id]).where("s#{@wday} = 1")
##    @timetableaps = @t.search(params[:id],params[:way_end],params[:search_al])

##    @airports = Airport.search(params[:search])
##    @timetableaps = Array.new
##    @airports.each do |arp|
#      @timetableaps0 = @t.search(params[:id],arp.id,params[:search_al])
##      @timetableaps = @timetableaps + @t.search(params[:id],arp.id,params[:search_al])
##     end
##########################################################################
#    render layout: "application_empty_1"
    authorize @airport
    respond_with(@airport)
	end

  def ap_dist
    @ap1 = Airport.find(params[:start_ap]) if params[:start_ap] != nil
    @ap2 = Airport.find(params[:end_ap]) if params[:end_ap] != nil
    if @ap1 != nil || @ap2 != nil
      @p1 = GeoPoint.new  @ap1.latitude.to_f, @ap1.longitude.to_f
      @p2 = GeoPoint.new  @ap2.latitude.to_f, @ap2.longitude.to_f
      @dist = @p1.distance_to(@p2)
      @sbear = @p1.bearing_to(@p2)
    end
  authorize :airport
  end
  
private
  def sort_column
    Airport.column_names.include?(params[:sort]) ? params[:sort] : "name_rus"
  end  

  def tbody_tablo_out
      @timetableap_subs = Array.new
      @timetableaps = Timetableap.where(way_start: @airport.id).where("s#{@wday} = ?",1)
      @airlines = Aircompany.where(:id => @timetableaps.select(:aircompany_id).group(:aircompany_id))
      @timetableaps = @timetableaps.search(params[:id],params[:end_ap],params[:search_al])
      @timetableaps.each do |tt|
        @timetableap_subs0 = TimetableapSub.where(timetableap_id: tt.id)
        if tt.TimeStart.hour < 24 - (DateTime.current.in_time_zone(@airport_time_zone).utc_offset / 3600)
          tt.timeIN = tt.TimeStart.change(:year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
        else
          tt.timeIN = tt.TimeStart.change(:year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
        end
        tt.s_ap = tt.airport
        tt.f_ap = tt.apkey.airport
        tt.f_aprus = tt.apkey.airport.name_rus
        tt.f_twrus = tt.apkey.airport.city_rus
        tt.s_aprus = tt.airport.name_rus
        tt.s_twrus = tt.airport.city_rus
        tt.aprus = tt.f_aprus
        tt.twrus = tt.f_twrus
        tt.ap = tt.f_ap
        tt.airline = tt.aircompany.airline_name_rus
        tt.al_plane = tt.aircompany.airline_name_rus
        tt.plane_al = tt.aircompany
        if tt.timeIN < Time.zone.now.utc
          tt.fstatus = "Вылетел"
          tt.bgcolor = "#32CD32"
        elsif tt.timeIN < Time.zone.now.utc+10.minute and tt.timeIN > Time.zone.now.utc
          tt.fstatus = "Выход закрыт"
          tt.bgcolor = "#9c0a0a"
        elsif tt.timeIN < Time.zone.now.utc+60.minute and tt.timeIN > Time.zone.now.utc+10.minute
          tt.fstatus = "Посадка"
          tt.bgcolor = "#F7110D"
        elsif tt.timeIN < Time.zone.now.utc+4.hour and tt.timeIN > Time.zone.now.utc+60.minute
          tt.fstatus = "регистрация"
          tt.bgcolor = "#A67C27"
        else
          tt.fstatus = "Ожидается вылет"
          tt.bgcolor = "#1C86EE"
        end
        @timetableap_subs0.each do |tt0|
          tt0.f_ap = tt.f_ap 
          tt0.s_ap = tt.s_ap 
          tt0.ap = tt.ap
          tt0.timeIN = tt.timeIN
          tt0.f_aprus = tt.f_aprus
          tt0.f_twrus = tt.f_twrus
          tt0.s_aprus = tt.s_aprus
          tt0.s_twrus = tt.s_twrus 
          tt0.aprus = tt0.timetableap.apkey.airport.name_rus
          tt0.apkey = tt0.timetableap.apkey
          tt0.twrus = tt0.timetableap.apkey.airport.city_rus
          tt0.fstatus = tt.fstatus
          tt0.bgcolor = tt.bgcolor
          tt0.airline = tt0.aircompany.airline_name_rus
          tt0.al_plane = tt.al_plane
          tt0.plane_al = tt0.timetableap.aircompany
        end
      @timetableap_subs = @timetableap_subs + @timetableap_subs0
    end
  end

  def tbody_tablo_in
    @timetableap_subs = Array.new
    @timetableaps = Timetableap.where(way_end: params[:id]).where("e#{@wday} = ?",1)
    @airlines = Aircompany.where(:id => @timetableaps.select(:aircompany_id).group(:aircompany_id))
    @timetableaps = @timetableaps.search(params[:start_ap],params[:id],params[:search_al])
    @timetableaps.each do |tt|
      @timetableap_subs0 = TimetableapSub.where(timetableap_id: tt.id)
      if tt.TimeEnd.hour < 24 - (Time.zone.now.utc_offset / 3600)
        tt.timeIN = tt.TimeEnd.change(:year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
      else
        tt.timeIN = tt.TimeEnd.change(:year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
      end
#      tt['timeIN'] = tt.timeEnd.in_time_zone(@airport_time_zone)
      tt.s_ap = tt.airport
      tt.f_ap = tt.apkey.airport
      tt.s_aprus = tt.airport.name_rus
      tt.s_twrus = tt.airport.town.city_rus
      tt.f_aprus = tt.apkey.airport.name_rus
      tt.f_twrus = tt.apkey.airport.city_rus
      tt.aprus = tt.s_aprus
      tt.twrus = tt.s_twrus
      tt.ap = tt.s_ap
      tt.airline = tt.aircompany.airline_name_rus
      tt.al_plane = tt.aircompany.airline_name_rus
      tt.plane_al = tt.aircompany
      if tt.timeIN < DateTime.current.in_time_zone(@airport_time_zone).utc
        tt.fstatus = "Прибыл"
        tt.bgcolor = "#32CD32"
      else
        tt.fstatus = "Ожидается прибытие"
        tt.bgcolor = "#1C86EE"
      end
      @timetableap_subs0.each do |tt0|
        tt0.f_ap = tt.f_ap
        tt0.s_ap = tt.s_ap
        tt0.f_aprus = tt.f_aprus
        tt0.f_twrus = tt.f_twrus
        tt0.s_aprus = tt.s_aprus
        tt0.s_twrus = tt.s_twrus
        tt0.timeIN = tt.timeIN
        tt0.aprus = tt0.timetableap.airport.name_rus
        tt0.twrus = tt0.timetableap.airport.town.city_rus
        tt0.fstatus = tt.fstatus
        tt0.bgcolor = tt.bgcolor
        tt0.apkey = tt0.timetableap.apkey
        tt0.airline = tt0.aircompany.airline_name_rus
        tt0.al_plane = tt.al_plane
        tt0.plane_al = tt0.timetableap.aircompany
      end
      @timetableap_subs = @timetableap_subs + @timetableap_subs0
    end
  end

  def tbody_tablo 
  end

  def set_airport
    @airport = Airport.find(params[:id])
  end
  protected

  def check_permissions
    authorize :airport
  end
end
