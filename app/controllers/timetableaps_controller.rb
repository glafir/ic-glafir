class TimetableapsController < ApplicationController
layout "application_empty_1", :only => [:flight_state]

  # GET /timetableaps
  # GET /timetableaps.json
  def index
    @timetableaps = Timetableap.select("*,(select city_rus from airports where airports.id = timetableaps.way_end) as city_rus_end,(select city_rus from airports where airports.id = timetableaps.way_start) as city_rus_start").search(params[:start_ap],params[:end_ap],params[:search_al])
    respond_with(@timetableap)
  end

  def ttair_admin
    render layout: "application_empty_1"
  end

  # GET /timetableaps/1
  # GET /timetableaps/1.json
  def show
    @timetableap = Timetableap.find(params[:id])
    respond_with(@timetableap)
  end

  # GET /timetableaps/new
  # GET /timetableaps/new.json
  def new
    @timetableap = Timetableap.new
    respond_with(@timetableap)
  end

  def update_dateoffinishdate
    render nothing: true
    @timetableap = Timetableap.find(params[:id])
    @timetableap.DateOfEndNav = @timetableap.DateOfEndNav + 1.year
    @timetableap.save
    respond_with(@timetableap)
  end

  def edit
    @timetableap = Timetableap.find(params[:id])
    respond_with(@timetableap)
  end

  def create
    @timetableap = Timetableap.new(params[:timetableap])
    @timetableap.save
    flash[:notice] = "The flight was saved!" if @timetableap.save && !request.xhr?
    respond_with(@timetableap, :location => timetableap_path(@timetableap))
  end

  def update
    @timetableap = Timetableap.find(params[:id])
    @timetableap.update_attributes(params[:timetableap])
    flash[:notice] = "The flight was updated!" if @timetableap.save && !request.xhr?
    respond_with(@timetableap, :location => timetableap_path(@timetableap))
  end

  def destroy
    @timetableap = Timetableap.find(params[:id])
    @timetableap.destroy
    respond_with(@timetableap)
  end

  def flight_state
    @timetableap = Timetableap.find(params[:id])
    if @timetableap.TimeEnd.hour < 14 or @timetableap.TimeStart.hour < 14
      @timetableap['timeEnd'] = @timetableap.TimeEnd.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
      @timetableap['timeStart'] = @timetableap.TimeStart.change( :year=>Time.zone.now.year, :month=>Time.zone.now.month, :day=>Time.zone.now.day)
    else
      @timetableap['timeEnd'] = @timetableap.TimeEnd.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
      @timetableap['timeStart'] = @timetableap.TimeStart.change( :year=>(Time.zone.now - 1.day).year, :month=>(Time.zone.now - 1.day).month, :day=>(Time.zone.now - 1.day).day)
    end
    respond_with(@timetableap)
  end

  def insert
    @timetableaps = Timetableap.all
    @timetableaps.each do |tt|
      tt << Time.now
    end
  end
end
