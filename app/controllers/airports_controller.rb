# -*- encoding : utf-8 -*-
class AirportsController < ApplicationController
layout "without_html", :only => [:tablo]
autocomplete :airport, :name_rus, :extra_data => [:iata_code]

#  def autocomplete_airport
#    iata_code = params[:iata_code]
#    town_id = params[:town_id]
#    name_rus = params[:name_rus]
#    airports = Airport.where('name_rus LIKE ? OR iata_code LIKE ?', brand_id, country, "%#{term}%").order(:name).all
#    render :json => airports.map { |airport| {:id => airport.id, :label => airport.name_eng, :value => airport.name_rus} }
#   end

  def admin_ap
    render layout: "application_empty_1"
  end

  def index
    @airports = Airport.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per_page])
  end

  def show
    @airport = Airport.find(params[:id])
    @aircompanies = Aircompany.where(airport_id: params[:id]).page(params[:page]).per(params[:per_page])
  end

  def aptt
    @airport = Airport.find(params[:id])
  end

  def city
    @airports = Airport.where(city_eng: params[:city_eng])
    @airports = @airports.paginate :page => params[:page], :order => 'name_rus'
  end

  def new
    @airport = Airport.new
    @apkey = Apkey.new
  end

  def edit
    @airport = Airport.find(params[:id])
  end

  def create
    @airport = Airport.new(params[:airport])
    @apkey = Apkey.new
    respond_to do |format|
      if @airport.save
        format.html { redirect_to @airport, notice: 'Airport was successfully created.' }
        format.json { render json: @airport, status: :created, location: @airport }
        @apkey.id = @airport.id
        @apkey.airport_id = @airport.id
        @apkey.save

      else
        format.html { render action: "new" }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @airport = Airport.find(params[:id])

    respond_to do |format|
      if @airport.update_attributes(params[:airport])
        format.html { redirect_to @airport, notice: 'Airport was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @airport = Airport.find(params[:id])
    @airport.destroy

    respond_to do |format|
      format.html { redirect_to airports_url }
      format.json { head :no_content }
    end
  end
  
  def tablo
    @wday = Time.zone.now.strftime'%w'.to_s
    @airport = Airport.find(params[:id])
    if params[:apt] == 'out'
      @tablo = "Табло вылета"
      tbody_tablo_out
      @timetableaps = @timetableaps + @timetableap_subs
    elsif params[:apt] == 'in'
      @tablo = "Табло Прибытия"
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
  end
  
private
  def sort_column
    Airport.column_names.include?(params[:sort]) ? params[:sort] : "name_rus"
  end  

  def tbody_tablo_out
      @timetableap_subs = Array.new
      @timetableaps = Timetableap.where(way_start: params[:id]).where("s#{@wday} = ?",1)
      @timetableaps.each do |tt|
        @timetableap_subs0 = TimetableapSub.where(timetableap_id: tt.id)
        if tt.TimeStart.hour < 14
          tt['timeIN'] = tt.TimeStart.change(:year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
        else
          tt['timeIN'] = tt.TimeStart.change(:year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
        end
        tt['aprus'] = tt.apkey.airport.name_rus
        tt['twrus'] = tt.apkey.airport.town.city_rus
        if tt['timeIN'] < Time.zone.now.utc
          tt['fstatus'] = "Вылетел"
          tt['bgcolor'] = "#32CD32"
        elsif tt['timeIN'] < Time.zone.now.utc+40.minute and tt['timeIN'] > Time.zone.now.utc
          tt['fstatus'] = "Посадка"
          tt['bgcolor'] = "#F7110D"
        elsif tt['timeIN'] < Time.zone.now.utc+2.hour and tt['timeIN'] > Time.zone.now.utc+40.minute
          tt['fstatus'] = "Идёт регистрация"
          tt['bgcolor'] = "#A67C27"
        else
          tt['fstatus'] = "Ожидается"
          tt['bgcolor'] = "#1C86EE"
        end
        @timetableap_subs0.each do |tt0|
          tt0['TimeIN'] = tt0.timetableap.TimeStart
          tt0['apkey'] = tt0.timetableap.apkey
          tt0['timeIN'] = tt['timeIN']
          tt0['aprus'] = tt0.timetableap.apkey.airport.name_rus
          tt0['twrus'] = tt0.timetableap.apkey.airport.town.city_rus
          tt0['fstatus'] = tt['fstatus']
          tt0['bgcolor'] = tt['bgcolor']
        end
      @timetableap_subs = @timetableap_subs + @timetableap_subs0
    end
  end

  def tbody_tablo_in
    @timetableap_subs = Array.new
    @timetableaps = Timetableap.where(way_end: params[:id]).where("e#{@wday} = ?",1)
    @timetableaps.each do |tt|
      @timetableap_subs0 = TimetableapSub.where(timetableap_id: tt.id)
      if tt.TimeEnd.hour < 14
        tt['timeIN'] = tt.TimeEnd.change(:year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
      else
        tt['timeIN'] = tt.TimeEnd.change(:year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
      end
      tt['aprus'] = tt.airport.name_rus
      tt['twrus'] = tt.airport.town.city_rus
      if tt['timeIN'] < Time.zone.now.utc
        tt['fstatus'] = "Прибыл"
        tt['bgcolor'] = "#32CD32"
      else
        tt['fstatus'] = "Ожидается"
        tt['bgcolor'] = "#1C86EE"
      end
      @timetableap_subs0.each do |tt0|
        tt0['TimeIN'] = tt0.timetableap.TimeEnd
        tt0['apkey'] = tt0.timetableap.apkey
        tt0['timeIN'] = tt['timeIN']
        tt0['aprus'] = tt0.timetableap.airport.name_rus
        tt0['twrus'] = tt0.timetableap.airport.town.city_rus
        tt0['fstatus'] = tt['fstatus']
        tt0['bgcolor'] = tt['bgcolor']
      end
      @timetableap_subs = @timetableap_subs + @timetableap_subs0
    end
  end

  def tbody_tablo 
  end
end
